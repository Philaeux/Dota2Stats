import os
import json
import urllib

from tornado.web import Application, RequestHandler
from tornado.websocket import WebSocketHandler
from tornado.options import define, options, parse_config_file
from tornado_sqlalchemy import as_future, make_session_factory, SessionMixin
from tornado.httpserver import HTTPServer
from tornado.ioloop import IOLoop

from image_generation.image_generator import ImageGenerator
from models import DotaHeroes, GroupStage, DotaProTeam


define('database_url', type=str, help='Database URL')
settings_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "settings.cfg")
parse_config_file(settings_file)


class NativeCoroutinesRequestHandler(SessionMixin, RequestHandler):
    async def get(self):
        count = await as_future(self.session.query(DotaHeroes).count)
        self.write('{} heroes so far!'.format(count))


class ImageRequestHandler(RequestHandler):
    def get(self, img):
        assets = os.path.join(os.path.dirname(os.path.abspath(__file__)), "assets")
        generated = os.path.join(assets, "generated", img)
        default = os.path.join(assets, "default.png")

        self.set_header("Content-type", "image/png")
        to_send = default
        if os.path.exists(generated):
            to_send = generated
        with open(to_send, 'rb') as file:
            self.write(file.read())


class CROSRequestHandler(RequestHandler):

    def set_default_headers(self):
        self.set_header("Access-Control-Allow-Origin", "*")
        self.set_header('Access-Control-Allow-Headers', "Content-Type, Depth, User-Agent, X-File-Size, X-Requested-With"
                        + ", X-Requested-By, If-Modified-Since, X-File-Name, Cache-Control")
        self.set_header('Access-Control-Allow-Methods', 'POST, GET, OPTIONS, PUT, DELETE')

    def options(self):
        self.set_status(204)
        self.finish()


class ImageGeneratorRequestHandler(CROSRequestHandler, SessionMixin):
    def initialize(self, image_generator):
        self.image_generator = image_generator
        self.image_generator.session = self.session

    async def post(self):
        request_body = json.loads(self.request.body)
        if 'image_type' not in request_body:
            self.write({"success": False, "error": "No image type specified"})
            return

        if request_body["image_type"] == "static_teams":
            if "team_id" not in request_body:
                self.write({"success": False, "error": "No team_id specified with static_team generation"})
                return

            self.image_generator.generate_static(request_body["team_id"])
            self.write(
                {"success": True, "error": ""}
            )
        elif request_body["image_type"] == "group_stage":
            self.image_generator.generate_group_stage()
            self.write(
                {"success": True, "error": ""}
            )
        elif request_body["image_type"] == "post_game":
            if ('game_id' not in request_body
                    or not request_body["game_id"].isdigit()
                    or int(request_body["game_id"]) <= 0):
                self.write({"success": False, "error": "Invalid game id specified"})
                return
            await self.image_generator.generate_post_game(int(request_body["game_id"]))
            self.write(
                {"success": True, "error": ""}
            )
        elif request_body["image_type"] == "tournament_globals":
            await self.image_generator.generate_tournament_globals()
            self.write(
                {"success": True, "error": ""}
            )
        elif request_body["image_type"] == "team_face_off":
            if ("team_id_1" not in request_body
                    or not request_body["team_id_1"].isdigit()
                    or int(request_body["team_id_1"]) <= 0
                    or "team_id_2" not in request_body
                    or not request_body["team_id_2"].isdigit()
                    or int(request_body["team_id_2"]) <= 0):
                self.write({"success": False, "error": "Invalid team_id_x specified"})
                return
            await self.image_generator.generate_team_face_off(int(request_body["team_id_1"]),
                                                              int(request_body["team_id_2"]))
            self.write(
                {"success": True, "error": ""}
            )
        elif request_body["image_type"] == "mvp":
            if ("game_id" not in request_body
                    or not request_body["game_id"].isdigit()
                    or int(request_body["game_id"]) <= 0):
                self.write({"success": False, "error": "Invalid game id specified"})
                return
            if ("slot" not in request_body
                    or request_body["slot"] not in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]):
                self.write({"success": False, "error": "Wrong slot"})
                return
            await self.image_generator.generate_mvp(int(request_body["game_id"]), int(request_body["slot"]))
            self.write(
                {"success": True, "error": ""}
            )
        else:
            self.write({"success": False, "error": "Unknown image type"})
        if self.session:
            self.session.close()


class SceneHandler(WebSocketHandler):
    clients = set()
    current_image = "default.png"

    def check_origin(self, origin):
        parsed_origin = urllib.parse.urlparse(origin)
        # TODO
        #return parsed_origin.netloc.endswith(".mydomain.com")
        return True

    def open(self):
        SceneHandler.clients.add(self)

        self.write_message({
            "image": self.current_image,
            "transition": "cut"
        })

    def on_message(self, message):
        message_json = json.loads(message)
        SceneHandler.current_image = message_json["image"]
        for client in self.clients:
            client.write_message(message)

    def on_close(self):
        SceneHandler.clients.remove(self)


class GroupStageListHandler(CROSRequestHandler, SessionMixin):

    def get(self):
        groups = []
        for group_team, team in self.session\
                .query(GroupStage, DotaProTeam)\
                .filter(GroupStage.team_id == DotaProTeam.id)\
                .order_by(GroupStage.group_number, GroupStage.position)\
                .all():
            groups.append(
                {"id": team.id, "name": team.name, "group_number": group_team.group_number,
                 "position": group_team.position, "color": group_team.color, "wins": group_team.wins,
                 "loses": group_team.loses})
        self.write(
            {"success": True, "error": "", "payload": {"groups": groups}}
        )


class GroupStageAddHandler(CROSRequestHandler, SessionMixin):

    async def post(self):
        args = json.loads(self.request.body)
        if "id" not in args:
            self.write({"success": False, "error": "No id specified in payload."})
            return

        count = await as_future(self.session.query(GroupStage).filter(GroupStage.team_id == args["id"]).count)
        if count != 0:
            self.write({"success": False, "error": "Team already in group stage."})
        else:
            new_team = GroupStage(args["id"])
            self.session.add(new_team)
            await as_future(self.session.commit)
            self.write({"success": True, "error": ""})


class GroupStageDeleteHandler(CROSRequestHandler, SessionMixin):

    async def post(self):
        args = json.loads(self.request.body)
        if "id" not in args:
            self.write({"success": False, "error": "No id specified in payload."})
            return

        team = await as_future(self.session.query(GroupStage).filter(GroupStage.team_id == args["id"]).one_or_none)
        if team is None:
            self.write({"success": False, "error": "Team not in group stage."})
        else:
            self.session.delete(team)
            await as_future(self.session.commit)
            self.write({"success": True, "error": ""})


class GroupStageUpdateHandler(CROSRequestHandler, SessionMixin):

    async def post(self):
        args = json.loads(self.request.body)
        if ("id" not in args or "group_number" not in args or "position" not in args or "wins" not in args
                or "loses" not in args or "color" not in args):
            self.write({"success": False, "error": "All parameters not specified in payload."})
            return

        team = await as_future(self.session.query(GroupStage).filter(GroupStage.team_id == args["id"]).one_or_none)
        if team is None:
            self.write({"success": False, "error": "Team not in group stage."})
        else:
            team.group_number = args["group_number"]
            team.position = args["position"]
            team.wins = args["wins"]
            team.loses = args["loses"]
            team.color = args["color"]
            await as_future(self.session.commit)
            self.write({"success": True, "error": ""})


def make_app(database_url):
    image_generator = ImageGenerator(os.path.join(os.path.dirname(os.path.abspath(__file__)), "assets"))
    urls = [
        (r"/api/img/(.*)", ImageRequestHandler),
        (r"/api/generate", ImageGeneratorRequestHandler, dict(image_generator=image_generator)),
        (r"/api/group_stage/list", GroupStageListHandler),
        (r"/api/group_stage/add", GroupStageAddHandler),
        (r"/api/group_stage/delete", GroupStageDeleteHandler),
        (r"/api/group_stage/update", GroupStageUpdateHandler),
        (r"/api/scene", SceneHandler)
    ]
    return Application(urls,
                       session_factory=make_session_factory(database_url, pool_size=100, max_overflow=200),
                       debug=True)


if __name__ == '__main__':
    assert options.database_url, "Need a database URL"

    app = make_app(options.database_url)
    server = HTTPServer(app)
    server.bind(9899)
    server.start(1)
    IOLoop.current().start()
