import decimal
import os
import types
import time
from PIL import Image, ImageDraw, ImageFont
from tornado_sqlalchemy import as_future
from tornado.gen import multi
from sqlalchemy import desc

from image_generation.helpers import draw_image, draw_image_advanced, draw_text_center_align, draw_alpha_rectangle
from models import DotaProPlayer, DotaJoinGlobalTeam, DotaJoinGlobalTeamHero


class CoreFaceOffMixin:

    async def generate_core_face_off(self, team_1, team_2):
        # Delete previous image
        generated_path = os.path.join(self.generated_root, "core_face_off-" + str(team_1) + "-" + str(team_2) + ".png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        # Fonts
        rift_title = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 72)
        rift_middle = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 48)
        rift_text = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 50)

        composition = Image.open(os.path.join(self.assets_root, 'background3.png')).convert('RGBA')
        image_draw = ImageDraw.Draw(composition)

        # Database access
        team_stats = await multi([
            as_future(self.session.query(DotaJoinGlobalTeam).filter(DotaJoinGlobalTeam.team_id == team_1).one_or_none),
            as_future(self.session.query(DotaJoinGlobalTeam).filter(DotaJoinGlobalTeam.team_id == team_2).one_or_none)
        ])
        players = await multi([
            as_future(self.session.query(DotaProPlayer)
                      .filter(DotaProPlayer.team_id == team_1,
                              DotaProPlayer.position <= 3)
                      .order_by(DotaProPlayer.position)
                      .limit(3).all),
            as_future(self.session.query(DotaProPlayer)
                      .filter(DotaProPlayer.team_id == team_2,
                              DotaProPlayer.position <= 3)
                      .order_by(DotaProPlayer.position)
                      .limit(3).all)
        ])

        draw_text_center_align(image_draw, [480, 30], '{0}'.format(team_stats[0].team_name), font=rift_title,
                               fill=self.colors['ti_purple'])
        draw_text_center_align(image_draw, [1440, 30], '{0}'.format(team_stats[1].team_name), font=rift_title,
                               fill=self.colors['ti_purple'])

        # Player
        player_face_height = 200
        col_start = [200, 960+200]
        row_start = [350, 650, 950]
        border_width = 5
        for i in range(0, 2):
            for j in range(0, len(players[i])):
                player = players[i][j]
                player_face_path = os.path.join(self.assets_root, "players", str(player.account_id) + ".png")
                if os.path.exists(player_face_path):
                    player_face = Image.open(player_face_path).convert('RGBA')
                    player_face_width = int(player_face.size[0] * player_face_height / player_face.size[1])
                    composition = draw_alpha_rectangle(composition,
                                                       [col_start[i] - border_width - int(player_face_width / 2.0),
                                                        row_start[j] - border_width - int(player_face_height / 2.0),
                                                        col_start[i] + border_width + player_face_width - int(
                                                            player_face_width / 2.0),
                                                        row_start[j] + border_width + player_face_height - int(
                                                            player_face_height / 2.0)],
                                                       fill=self.colors["ti_purple"], alpha=0.8)
                    composition = draw_alpha_rectangle(composition,
                                                       [col_start[i] - int(player_face_width / 2.0),
                                                        row_start[j] - int(player_face_height / 2.0),
                                                        col_start[i] + player_face_width - int(player_face_width / 2.0),
                                                        row_start[j] + player_face_height - int(player_face_height / 2.0)],
                                                       fill=self.colors["black"], alpha=0.8)

                    composition = draw_image_advanced(composition, player_face,
                                                      [col_start[i],
                                                       row_start[j]],
                                                      [None, player_face_height],
                                                      1)

        image_draw.text([100, 100], str(time.time()), font=rift_title, fill=self.colors['light_red'])
        image_draw.text([100, 200], "Core Face off bouffon", font=rift_title, fill=self.colors['light_red'])

        composition.save(generated_path)
