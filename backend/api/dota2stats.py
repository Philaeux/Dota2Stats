import os
import json
import urllib

from sqlalchemy import Integer, BigInteger, Column, String
from tornado.web import Application, RequestHandler
from tornado.websocket import WebSocketHandler
from tornado.options import define, options, parse_config_file
from tornado_sqlalchemy import as_future, make_session_factory, SessionMixin, declarative_base
from tornado.httpserver import HTTPServer
from tornado.ioloop import IOLoop

from image_generator import ImageGenerator

DeclarativeBase = declarative_base()
define('database_url', type=str, help='Database URL')
settings_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "settings.cfg")
parse_config_file(settings_file)


class DotaHeroes(DeclarativeBase):
    __tablename__ = 'dota_heroes'

    id = Column(Integer, primary_key=True)
    name = Column(String(255), unique=True)
    short_name = Column(String(255), unique=True)
    display_name = Column(String(255), unique=True)


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
        self.set_header('Access-Control-Allow-Methods', 'POST, GET, OPTIONS')

    def options(self):
        self.set_status(204)
        self.finish()


class ImageGeneratorRequestHandler(CROSRequestHandler):
    def initialize(self, image_generator):
        self.image_generator = image_generator

    def post(self):
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
                {"success": True}
            )
        else:
            self.write({"success": False, "error": "Unknown image type"})


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


def make_app(database_url):
    image_generator = ImageGenerator(os.path.join(os.path.dirname(os.path.abspath(__file__)), "assets"))
    urls = [
        (r"/api/img/(.*)", ImageRequestHandler),
        (r"/api/generate", ImageGeneratorRequestHandler, dict(image_generator=image_generator)),
        (r"/api/scene", SceneHandler)
    ]
    return Application(urls,
                       session_factory=make_session_factory(database_url),
                       debug=True)


if __name__ == '__main__':
    assert options.database_url, "Need a database URL"

    app = make_app(options.database_url)
    server = HTTPServer(app)
    server.bind(9899)
    server.start(1)
    IOLoop.current().start()
