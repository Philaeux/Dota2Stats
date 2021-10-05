from itertools import chain
import time
import os
import math

from tornado_sqlalchemy import as_future
from tornado.gen import multi
from PIL import Image, ImageDraw, ImageColor, ImageFont

from models import DotaProPlayer, DotaHeroes, DotaItem, DotaProTeam
from image_generation.helpers import draw_text_outlined_center_align, draw_text_right_align, draw_image, \
    draw_image_centered


class PostGameV2Mixin:

    async def generate_post_game_v2(self, game_id):
        generated_path = os.path.join(self.generated_root, "post_game_v2-" + str(game_id) + ".png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        # Generate image
        composition = Image.open(os.path.join(self.assets_root, 'background3.png')).convert('RGBA')
        image_draw = ImageDraw.Draw(composition)

        # Prepare fonts
        rift_player_nickname = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold_italic.otf'), 46)
        noto_cjk_player_nickname = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'noto', 'noto_sans_cjk_bold.otf'), 38)
        rift_player_name = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 26)
        rift_kda = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 32)
        rift_dmg = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 32)
        rift_team = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 50)

        # Get data
        game_json = self.download_opendata_if_necessary(game_id)
        if game_json is None or game_json['version'] is None:
            image_draw.text([100, 100], str(time.time()), font=rift_player_nickname, fill=self.colors['light_red'])
            image_draw.text([100, 200], "ERROR WITH OPENDOTA", font=rift_player_nickname, fill=self.colors['light_red'])
            composition.save(generated_path)
            return

        # TODO INSERT AUTOWASH CODE HERE TO DRAW ON PICTURE
        draw_text_outlined_center_align(
            draw=image_draw, position=[960, 35], text='TODO',
            font=rift_player_nickname, fill=self.colors['ti_purple'], outline_fill=self.colors['black'], outline_width=4)

        composition.save(generated_path)
