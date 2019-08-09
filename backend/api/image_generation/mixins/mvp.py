from itertools import chain
import time
import os
import math

from tornado_sqlalchemy import as_future
from tornado.gen import multi
from PIL import Image, ImageDraw, ImageColor, ImageFont

from models import DotaProPlayer, DotaHeroes, DotaItem, DotaProTeam
from image_generation.helpers import draw_text_outlined_center_align, draw_text_left_align, draw_image, \
    draw_image_centered, draw_image_advanced, draw_alpha_rectangle, draw_image_advanced_left


class MvpMixin:

    async def generate_mvp(self, game_id, slot):
        generated_path = os.path.join(self.generated_root, "mvp-" + str(game_id) + ".png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        # Generate image
        composition = Image.open(os.path.join(self.assets_root, 'background2.png')).convert('RGBA')
        image_draw = ImageDraw.Draw(composition)

        # Prepare fonts
        rift_player_nickname = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold_italic.otf'), 115)
        noto_cjk_player_nickname = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'noto', 'noto_sans_cjk_bold.otf'), 38)
        rift_title = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 125)
        rift_player_name = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 48)
        rift_kda = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 100)

        # Get data
        game_json = self.download_opendata_if_necessary(game_id)
        if game_json is None or game_json['version'] is None:
            image_draw.text([100, 100], str(time.time()), font=rift_player_nickname, fill=self.colors['light_red'])
            image_draw.text([100, 200], "ERROR WITH OPENDOTA", font=rift_player_nickname, fill=self.colors['light_red'])
            composition.save(generated_path)
            return

        # Get database data
        player_json = None
        for player in game_json["players"]:
            if player["player_slot"] == slot or player["player_slot"] == slot + 123:
                player_json = player
                break
            else:
                continue
        player_account_id = player_json["account_id"]
        hero_id = player_json["hero_id"]

        player_info, hero_info, items = await multi([
            as_future(
                self.session.query(DotaProPlayer).filter(DotaProPlayer.account_id == player_account_id).one_or_none),
            as_future(self.session.query(DotaHeroes).filter(DotaHeroes.id == hero_id).one_or_none),
            as_future(self.session.query(DotaItem).all)
        ])

        if player_info is None or hero_info is None:
            image_draw.text([100, 100], str(time.time()), font=rift_player_nickname, fill=self.colors['light_red'])
            image_draw.text([100, 200], "ERROR WITH PLAYER POSITION/SIDE/DATA", font=rift_player_nickname,
                            fill=self.colors['light_red'])
            composition.save(generated_path)
            return

        logo_array = {
            15: {'offset': [-25, 100], 'size': [None, 150], 'suffix': '-horiz'},
            36: {'offset': [-25, 100], 'size': [None, 200], 'suffix': ''},
            39: {'offset': [-25, 100], 'size': [None, 150], 'suffix': ''},
            2163: {'offset': [-25, 100], 'size': [None, 200], 'suffix': '-solid'},
            111474: {'offset': [-25, 100], 'size': [None, 200], 'suffix': ''},
            350190: {'offset': [-25, 100], 'size': [None, 150], 'suffix': ''},
            543897: {'offset': [-25, 100], 'size': [None, 200], 'suffix': ''},
            726228: {'offset': [-25, 100], 'size': [None, 200], 'suffix': ''},
            1375614: {'offset': [-25, 100], 'size': [None, 200], 'suffix': ''},
            1838315: {'offset': [-75, 100], 'size': [None, 150], 'suffix': '-silver'},
            1883502: {'offset': [-25, 100], 'size': [None, 200], 'suffix': '-ti9'},
            2108395: {'offset': [-25, 100], 'size': [None, 200], 'suffix': ''},
            2586976: {'offset': [-15, 100], 'size': [None, 200], 'suffix': ''},
            2626685: {'offset': [-15, 100], 'size': [None, 200], 'suffix': ''},
            5065748: {'offset': [-5, 100], 'size': [None, 200], 'suffix': ''},
            6209804: {'offset': [-25, 100], 'size': [None, 150], 'suffix': ''},
            6214973: {'offset': [-25, 100], 'size': [None, 180], 'suffix': ''},
            6666989: {'offset': [-25, 100], 'size': [None, 180], 'suffix': ''},
        }
        logo_x = 900
        logo_y = 320
        player_face_x = 375
        player_face_y = 550
        player_face_height = 550
        aegis_x = 960
        aegis_y = 200
        aegis_height = 700
        hero_x = logo_x - 150
        hero_y = logo_y + 250
        hero_height = 186
        hero_border = 4
        item_hero_padding_y = 20
        player_nickname_padding_x = 125
        player_name_padding_y = 125

        # Title
        aegis_path = os.path.join(self.assets_root, "aegis.png")
        aegis = Image.open(aegis_path).convert('RGBA')
        composition = draw_image_advanced(composition, aegis,
                                          [aegis_x,
                                           aegis_y],
                                          [None, aegis_height],
                                          0.8)
        image_draw = ImageDraw.Draw(composition)
        draw_text_outlined_center_align(image_draw, [960, 60], 'Most Valuable Player', rift_title,
                                        fill=self.colors['ti_purple'], outline_fill=self.colors['black'],
                                        outline_width=4)

        # Logo
        team_id = player_info.team_id
        logo_path = os.path.join(self.teams_data, str(team_id),
                                 "logo-" + str(team_id) + logo_array[team_id]["suffix"] + ".png")
        if os.path.exists(logo_path):
            logo = Image.open(logo_path).convert('RGBA')
            composition = draw_image_advanced(composition, logo,
                                              [logo_x + logo_array[team_id]["offset"][0],
                                               logo_y + logo_array[team_id]["offset"][1]],
                                              logo_array[team_id]["size"],
                                              1)

        # Player
        player_face_path = os.path.join(self.assets_root, "players", str(player_info.account_id) + ".png")

        if os.path.exists(player_face_path):
            player_face = Image.open(player_face_path).convert('RGBA')
            player_face_width = int(player_face.size[0] * player_face_height / player_face.size[1])
            composition = draw_alpha_rectangle(composition,
                                               [player_face_x - hero_border - int(player_face_width / 2.0),
                                                player_face_y - hero_border - int(player_face_height / 2.0),
                                                player_face_x + hero_border + player_face_width - int(
                                                    player_face_width / 2.0),
                                                player_face_y + hero_border + player_face_height - int(
                                                    player_face_height / 2.0)],
                                               fill=self.colors["ti_purple"], alpha=0.8)
            composition = draw_alpha_rectangle(composition,
                                               [player_face_x - int(player_face_width / 2.0),
                                                player_face_y - int(player_face_height / 2.0),
                                                player_face_x + player_face_width - int(player_face_width / 2.0),
                                                player_face_y + player_face_height - int(player_face_height / 2.0)],
                                               fill=self.colors["black"], alpha=0.8)

            composition = draw_image_advanced(composition, player_face,
                                              [player_face_x,
                                               player_face_y],
                                              [None, player_face_height],
                                              1)

        # Hero
        hero_image = Image.open(
            os.path.join(self.assets_root, 'dota', 'hero_rectangle', hero_info.short_name + '.png')).convert('RGBA')
        hero_width = int(hero_image.size[0] * hero_height / hero_image.size[1])
        composition = draw_alpha_rectangle(composition, [hero_x - hero_border, hero_y - hero_border,
                                                         hero_x + hero_width + hero_border,
                                                         hero_y + hero_height + hero_border],
                                           fill=self.colors["ti_purple"], alpha=0.8)
        draw_image(composition, hero_image, [hero_x, hero_y], [None, hero_height])

        image_draw = ImageDraw.Draw(composition)

        # Draw Items
        item_empty = Image.open(os.path.join(self.assets_root, 'dota', 'item_rectangle', 'empty.png'))
        item_width = int(hero_width / 3.0)
        item_height = int(item_empty.size[1] * item_width / item_empty.size[0])
        composition = draw_alpha_rectangle(composition, [hero_x - hero_border,
                                                         hero_y + hero_height + item_hero_padding_y - hero_border,
                                                         hero_x + hero_width + hero_border,
                                                         hero_y + 2 * item_height + hero_height + item_hero_padding_y + hero_border],
                                           fill=self.colors["ti_purple"], alpha=0.8)
        for j in range(0, 2):
            for i in range(0, 3):
                key = 'item_{0}'.format(j * 3 + i)
                if player_json[key] != 0:
                    item = next((item for item in items if item.id == player[key]), None)
                    if item is None:
                        short_name = 'error'
                    else:
                        short_name = item.short_name
                    item_path = os.path.join(self.assets_root, 'dota', 'item_rectangle', short_name + '.png')
                    if not os.path.exists(item_path):
                        item_path = os.path.join(self.assets_root, 'dota', 'item_rectangle', 'default.png')
                    item_image = Image.open(item_path).convert('RGBA')
                else:
                    item_image = item_empty
                draw_image(composition,
                           item_image,
                           [hero_x + i * item_width,
                            hero_y + item_hero_padding_y + hero_height + j * item_height],
                           [None, item_height])
        has_moon = False
        has_agh = False
        if player_json["permanent_buffs"] is not None:
            for permanent_buff in player_json["permanent_buffs"]:
                if permanent_buff["permanent_buff"] == 1:
                    has_moon = True
                elif permanent_buff["permanent_buff"] == 2:
                    has_agh = True
        if has_agh:
            composition = draw_alpha_rectangle(
                composition,
                [hero_x + int(item_width / 2.0)-hero_border,
                 hero_y + 2*item_hero_padding_y + hero_height + 2 * item_height + 2 * hero_border - hero_border,
                 hero_x + int(item_width / 2.0) + item_width + hero_border,
                 hero_y + 2*item_hero_padding_y + hero_height + 2 * item_height + 2 * hero_border + item_height + hero_border],
                fill=self.colors["ti_purple"], alpha=0.8
            )
        if has_moon:
            composition = draw_alpha_rectangle(
                composition,
                [hero_x + int(item_width / 2.0) + item_width - hero_border,
                 hero_y + 2 * item_hero_padding_y + hero_height + 2 * item_height + 2 * hero_border - hero_border,
                 hero_x + int(item_width / 2.0) + 2*item_width + hero_border,
                 hero_y + 2 * item_hero_padding_y + hero_height + 2 * item_height + 2 * hero_border + item_height + hero_border],
                fill=self.colors["ti_purple"], alpha=0.8
            )
        if has_agh:
            agh_image = Image.open(os.path.join(self.assets_root, 'dota', 'item_rectangle', 'ultimate_scepter.png'))
            draw_image(composition, agh_image,
                       [hero_x + int(item_width / 2.0),
                        hero_y + 2*item_hero_padding_y + hero_height + 2 * item_height + 2 * hero_border],
                       [None, item_height])
        if has_moon:
            moon_image = Image.open(os.path.join(self.assets_root, 'dota', 'item_rectangle', 'moon_shard.png'))
            draw_image(composition, moon_image,
                       [hero_x + 2 * item_width - int(item_width / 2.0),
                        hero_y + 2*item_hero_padding_y + hero_height + 2 * item_height + 2 * hero_border],
                       [None, item_height])

        image_draw = ImageDraw.Draw(composition)

        # Names
        player_name_font = rift_player_nickname
        if not len(player_info.nickname) == len(player_info.nickname.encode()):
            player_name_font = noto_cjk_player_nickname
        image_draw.text([logo_x + player_nickname_padding_x, logo_y], player_info.nickname, font=player_name_font,
                        fill=self.colors['white'])
        image_draw.text([logo_x + player_nickname_padding_x, logo_y + player_name_padding_y], player_info.name,
                        font=rift_player_name, fill=self.colors['white'])

        # Stats
        stat_col_1 = 1105
        stat_row_1 = 550
        row_height = 150
        col_width = 460
        icon_width = 80
        icon_stat_padding = 20

        # Draw icons
        skull_image = Image.open(os.path.join(self.assets_root, 'icons', 'skull.png')).convert('RGBA')
        composition = draw_image_advanced(composition, skull_image,
                                          [stat_col_1 + int(icon_width / 2),
                                           stat_row_1 + int(icon_width / 2) + 25],
                                          [None, icon_width],
                                          1)
        fight_icon = Image.open(os.path.join(self.assets_root, 'icons', 'fight.png')).convert('RGBA')
        composition = draw_image_advanced(composition, fight_icon,
                                          [stat_col_1 + col_width + int(icon_width / 2),
                                           stat_row_1 + 2*row_height + int(icon_width / 2) + 15],
                                          [None, icon_width],
                                          1)
        sword_image = Image.open(os.path.join(self.assets_root, 'icons', 'sword.png')).convert('RGBA')
        composition = draw_image_advanced(composition, sword_image,
                                          [stat_col_1 + int(icon_width / 2),
                                           stat_row_1 + row_height + int(icon_width / 2) + 25],
                                          [None, icon_width],
                                          1)
        tour_image = Image.open(os.path.join(self.assets_root, 'icons', 'tower.png')).convert('RGBA')
        composition = draw_image_advanced(composition, tour_image,
                                          [stat_col_1 + int(icon_width / 2),
                                           stat_row_1 + 2*row_height + int(icon_width / 2) + 25],
                                          [None, icon_width],
                                          1)
        if player_info.position <= 3:
            gold_icon = Image.open(os.path.join(self.assets_root, 'icons', 'gold.png')).convert('RGBA')
            composition = draw_image_advanced(composition, gold_icon,
                                              [stat_col_1 + col_width + int(icon_width / 2),
                                               stat_row_1 + int(icon_width / 2) + 20],
                                              [None, icon_width],
                                              1)
            efficiency_icon = Image.open(os.path.join(self.assets_root, 'icons', 'efficiency.png')).convert('RGBA')
            composition = draw_image_advanced(composition, efficiency_icon,
                                              [stat_col_1 + col_width + int(icon_width / 2),
                                               stat_row_1 + row_height + int(icon_width / 2) + 20],
                                              [None, icon_width],
                                              1)
        else:
            stun_icon = Image.open(os.path.join(self.assets_root, 'icons', 'stun.png')).convert('RGBA')
            composition = draw_image_advanced(composition, stun_icon,
                                              [stat_col_1 + col_width + int(icon_width / 2),
                                               stat_row_1 + int(icon_width / 2) + 20],
                                              [None, icon_width],
                                              1)
            vision_icon = Image.open(os.path.join(self.assets_root, 'icons', 'vision.png')).convert('RGBA')
            composition = draw_image_advanced(composition, vision_icon,
                                              [stat_col_1 + col_width + int(icon_width / 2),
                                               stat_row_1 + row_height + int(icon_width / 2) + 20],
                                              [None, icon_width],
                                              1)

        image_draw = ImageDraw.Draw(composition)

        stats_string = "{0} / {1} / {2}".format(
            player_json["kills"],
            player_json["deaths"],
            player_json["assists"]
        )
        image_draw.text([stat_col_1 + icon_width + icon_stat_padding, stat_row_1], stats_string, font=rift_kda, fill=self.colors["white"])
        teamfight_participation = "{0:.0f} %".format(player_json["teamfight_participation"]*100)
        image_draw.text([stat_col_1 + col_width + icon_width + icon_stat_padding, stat_row_1 + 2*row_height], teamfight_participation, font=rift_kda, fill=self.colors["white"])
        image_draw.text([stat_col_1 + icon_width + icon_stat_padding, stat_row_1 + row_height], str(player_json["hero_damage"]), font=rift_kda, fill=self.colors["white"])
        image_draw.text([stat_col_1 + icon_width + icon_stat_padding, stat_row_1 + 2*row_height], str(player_json["tower_damage"]), font=rift_kda, fill=self.colors["white"])

        if player_info.position <= 3:
            lane_efficiency = "{0:.0f} %".format(player_json["lane_efficiency"]*100)
            gpm = "{0:.0f}".format(player_json["total_gold"]*60.0/player_json["duration"])
            image_draw.text([stat_col_1 + col_width + icon_width + icon_stat_padding, stat_row_1], gpm, font=rift_kda, fill=self.colors["white"])
            image_draw.text([stat_col_1 + col_width + icon_width + icon_stat_padding, stat_row_1 + row_height], lane_efficiency, font=rift_kda, fill=self.colors["white"])
        else:
            stun = '{0:.0f} "'.format(player_json.get("stuns", 0))
            wards = "{0}/{1}".format(player_json.get("purchase_ward_observer", 0), player_json.get("purchase_ward_sentry", 0))
            image_draw.text([stat_col_1 + col_width + icon_width + icon_stat_padding, stat_row_1], stun, font=rift_kda, fill=self.colors["white"])
            image_draw.text([stat_col_1 + col_width + icon_width + icon_stat_padding, stat_row_1 + row_height], wards, font=rift_kda, fill=self.colors["white"])

        composition.save(generated_path)
