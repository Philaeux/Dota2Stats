import math
import os
import requests
import json

from PIL import ImageColor

from image_generation.mixins.static_teams import StaticTeamsMixin
from image_generation.mixins.group_stage import GroupStageMixin
from image_generation.mixins.post_game import PostGameMixin
from image_generation.mixins.tournament_globals import TournamentGlobalsMixin
from image_generation.mixins.team_face_off import TeamFaceOffMixin
from image_generation.mixins.core_face_off import CoreFaceOffMixin
from image_generation.mixins.support_face_off import SupportFaceOffMixin
from image_generation.mixins.mvp import MvpMixin


class ImageGenerator(StaticTeamsMixin, GroupStageMixin, PostGameMixin, TournamentGlobalsMixin, TeamFaceOffMixin,
                     MvpMixin, CoreFaceOffMixin, SupportFaceOffMixin):

    colors = {
        'hero_blue': ImageColor.getrgb('#3375ff'),
        'hero_teal': ImageColor.getrgb('#65fdbd'),
        'hero_purple': ImageColor.getrgb('#bf00bf'),
        'hero_yellow': ImageColor.getrgb('#f3f00b'),
        'hero_orange': ImageColor.getrgb('#ff6b00'),
        'hero_pink': ImageColor.getrgb('#fc85c0'),
        'hero_grey': ImageColor.getrgb('#a0b346'),
        'hero_aqua': ImageColor.getrgb('#65d9f7'),
        'hero_green': ImageColor.getrgb('#008321'),
        'hero_brown': ImageColor.getrgb('#a46900'),
        'white': ImageColor.getrgb('#ffffff'),
        'ti_green': ImageColor.getrgb('#83a94c'),
        'ti_purple': ImageColor.getrgb('#8b41c4'),
        'black': ImageColor.getrgb('#000000'),
        'orange': ImageColor.getrgb('#ff6a38'),
        'yellow': ImageColor.getrgb('#FFDF00'),
        'blue': ImageColor.getrgb('#00c8ff'),
        'grey': ImageColor.getrgb('#cecece'),
        'light_blue': ImageColor.getrgb('#4C83A9'),
        'light_red': ImageColor.getrgb('#E75348'),
        'light_grey': ImageColor.getrgb('#aaaaaa'),
        'dota_green': ImageColor.getrgb('#00bb00'),
        'dota_red': ImageColor.getrgb('#bb0000')
    }

    def __init__(self, assets_root):
        self.tournament_id = 10826
        self.session = None
        self.assets_root = assets_root
        self.generated_root = os.path.join(assets_root, "generated")
        self.teams_data = os.path.join(assets_root, "teams")

    def download_opendata_if_necessary(self, game_id):
        # Delete previous data if invalid
        json_path = os.path.join(self.generated_root, "game-" + str(game_id) + ".json")
        if os.path.isfile(json_path):
            with open(json_path, 'r') as json_file:
                json_content = json.loads(json_file.read())
            if json_content['version'] is None:
                os.remove(json_path)
            else:
                return json_content

        # Download json to file
        r = requests.get("https://api.opendota.com/api/matches/{0}".format(game_id))
        if r.status_code != 200:
            return None

        json_content = r.json()
        if json_content['version'] is None:
            return None
        with open(json_path, "w") as json_file:
            json_file.write(json.dumps(json_content))

        return json_content

    @staticmethod
    def duration_to_string(duration):
        duration_sec = math.ceil(duration) % 60
        duration_min = int(math.ceil(duration - duration_sec) / 60)
        return '{0:02}:{1:02}'.format(duration_min, duration_sec)
