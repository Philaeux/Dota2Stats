import decimal
import os
import types
import time
from PIL import Image, ImageDraw, ImageFont
from tornado_sqlalchemy import as_future
from tornado.gen import multi
from sqlalchemy import desc

from image_generation.helpers import draw_image, draw_image_advanced, draw_text_center_align, draw_alpha_rectangle, \
    draw_text_right_align
from models import DotaProPlayer, DotaProTeam, DotaJoinGlobalPlayerHero


class CoreFaceOffMixin:

    async def generate_core_face_off(self, team_1, team_2):
        # Delete previous image
        generated_path = os.path.join(self.generated_root, "core_face_off-" + str(team_1) + "-" + str(team_2) + ".png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        # Fonts
        rift_title = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 72)
        rift_player_nickname = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold_italic.otf'), 46)
        noto_cjk_player_nickname = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'noto', 'noto_sans_cjk_bold.otf'), 38)
        rift_middle = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 48)
        rift_text = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 50)

        composition = Image.open(os.path.join(self.assets_root, 'background3.png')).convert('RGBA')
        image_draw = ImageDraw.Draw(composition)

        # Database access
        teams = await multi([
            as_future(self.session.query(DotaProTeam).filter(DotaProTeam.id == team_1).one_or_none),
            as_future(self.session.query(DotaProTeam).filter(DotaProTeam.id == team_2).one_or_none)
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

        draw_text_center_align(image_draw, [480, 30], '{0}'.format(teams[0].name), font=rift_title,
                               fill=self.colors['ti_purple'])
        draw_text_center_align(image_draw, [1440, 30], '{0}'.format(teams[1].name), font=rift_title,
                               fill=self.colors['ti_purple'])

        # Player
        player_face_height = 200
        border_width = 5
        hero_height = int((player_face_height + 2 * border_width) / 3)
        row_start = [350, 650, 950]
        image_center_x = 960
        player_face_center_x = 800
        nickname_padding = 35

        for i in range(0, 2):
            for j in range(0, len(players[i])):
                player = players[i][j]

                player_heroes = await  as_future(
                    self.session.query(DotaJoinGlobalPlayerHero)
                        .filter(DotaJoinGlobalPlayerHero.account_id == player.account_id)
                        .order_by(desc(DotaJoinGlobalPlayerHero.nb_pick))
                        .limit(3).all)

                for index, hero in enumerate(player_heroes):
                    print(hero)
                    hero_path = os.path.join(self.assets_root, "dota", "hero_rectangle", hero.short_name + ".png")
                    if os.path.exists(hero_path):
                        hero_image = Image.open(hero_path).convert('RGBA')
                        composition = draw_image_advanced(composition, hero_image,
                                                          [image_center_x + pow(-1, i+1)*(player_face_center_x - player_face_height - int(hero_height/2)),
                                                           row_start[j] + index*hero_height - int(player_face_height/2) + int(hero_height/2) - border_width],
                                                          [None, hero_height],
                                                          1)

                image_draw = ImageDraw.Draw(composition)
                player_name_font = rift_player_nickname
                if not len(player.nickname) == len(player.nickname.encode()):
                    player_name_font = noto_cjk_player_nickname

                if i == 1:
                    draw_text_right_align(image_draw,
                                          position=[image_center_x + player_face_center_x + int(player_face_height / 2),
                                                    row_start[j] - player_face_height + nickname_padding],
                                          text=player.nickname,
                                          font=player_name_font,
                                          fill=self.colors['white'])
                else:
                    image_draw.text(xy=[image_center_x - player_face_center_x - int(player_face_height / 2),
                                        row_start[j] - player_face_height + nickname_padding],
                                    text=player.nickname,
                                    font=player_name_font,
                                    fill=self.colors['white'])

                player_face_path = os.path.join(self.assets_root, "players", str(player.account_id) + ".png")
                if os.path.exists(player_face_path):
                    player_face = Image.open(player_face_path).convert('RGBA')
                    composition = draw_alpha_rectangle(composition,
                                                       [image_center_x + pow(-1, i+1)*player_face_center_x - border_width - int(player_face_height/2),
                                                        row_start[j] - border_width - int(player_face_height/2),
                                                        image_center_x + pow(-1, i+1)*player_face_center_x + border_width + int(player_face_height/2),
                                                        row_start[j] + border_width + int(player_face_height/2)],
                                                       fill=self.colors["ti_purple"], alpha=0.8)
                    composition = draw_alpha_rectangle(composition,
                                                       [image_center_x + pow(-1, i+1)*player_face_center_x - int(player_face_height/2),
                                                        row_start[j] - int(player_face_height/2),
                                                        image_center_x + pow(-1, i+1)*player_face_center_x + int(player_face_height/2),
                                                        row_start[j] + int(player_face_height/2)],
                                                       fill=self.colors["black"], alpha=0.8)
                    composition = draw_image_advanced(composition, player_face,
                                                      [image_center_x + pow(-1, i+1)*player_face_center_x,
                                                       row_start[j]],
                                                      [None, player_face_height],
                                                      1)
                    image_draw = ImageDraw.Draw(composition)

        composition.save(generated_path)
