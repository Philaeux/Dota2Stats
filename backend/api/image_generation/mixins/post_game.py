from itertools import chain
import time
import os
import math

from tornado_sqlalchemy import as_future
from tornado.gen import multi
from PIL import Image, ImageDraw, ImageColor, ImageFont

from models import DotaProPlayer, DotaHeroes, DotaItem, DotaProTeam
from image_generation.helpers import draw_text_outlined_center_align, draw_text_left_align, draw_image, \
    draw_image_centered


class PostGameMixin:

    async def generate_post_game(self, game_id):
        generated_path = os.path.join(self.generated_root, "post_game-" + str(game_id) + ".png")
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

        hero_x = 350
        hero_y_side_padding = 30
        hero_height = 90
        hero_width = int(256 * hero_height / 144)
        hero_y_padding = 10
        item_padding = 4
        item_height = int((hero_height - item_padding) / 2)
        item_width = int(88 * item_height / 64)
        player_name_x_padding = -40
        player_name_y_padding = 0
        player_nickname_y_padding = 50
        kda_padding_x = 5
        hero_y = {0: hero_y_side_padding,
                  1: hero_y_side_padding + hero_height + hero_y_padding,
                  2: hero_y_side_padding + 2 * (hero_height + hero_y_padding),
                  3: hero_y_side_padding + 3 * (hero_height + hero_y_padding),
                  4: hero_y_side_padding + 4 * (hero_height + hero_y_padding),
                  128: 1080 - hero_y_side_padding - hero_height * 5 - hero_y_padding * 4,
                  129: 1080 - hero_y_side_padding - hero_height * 4 - hero_y_padding * 3,
                  130: 1080 - hero_y_side_padding - hero_height * 3 - hero_y_padding * 2,
                  131: 1080 - hero_y_side_padding - hero_height * 2 - hero_y_padding,
                  132: 1080 - hero_y_side_padding - hero_height}
        hero_color = {0: self.colors['hero_blue'],
                      1: self.colors['hero_teal'],
                      2: self.colors['hero_purple'],
                      3: self.colors['hero_yellow'],
                      4: self.colors['hero_orange'],
                      128: self.colors['hero_pink'],
                      129: self.colors['hero_grey'],
                      130: self.colors['hero_aqua'],
                      131: self.colors['hero_green'],
                      132: self.colors['hero_brown']}
        hero_color_width = 10

        # Get database data
        heroes, items, players, teams = await multi([as_future(self.session.query(DotaHeroes).all),
                                                     as_future(self.session.query(DotaItem).all),
                                                     as_future(self.session.query(DotaProPlayer).all),
                                                     as_future(self.session.query(DotaProTeam).all)])

        # Draw Heroes & Items
        for player in game_json['players']:
            hero = next((hero for hero in heroes if hero.id == player['hero_id']), None)
            if hero is None:
                short_name = 'error'
            else:
                short_name = hero.short_name
            hero_image = Image.open(os.path.join(self.assets_root, 'dota', 'hero_rectangle', short_name + '.png')) \
                .convert('RGBA')
            draw_image(composition, hero_image, [hero_x, hero_y[player['player_slot']]], [None, hero_height])

            # Draw Items
            for j in range(0, 2):
                for i in range(0, 3):
                    key = 'item_{0}'.format(j * 3 + i)
                    if player[key] != 0:
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
                        item_image = Image.open(os.path.join(self.assets_root, 'dota', 'item_rectangle', 'empty.png')) \
                            .convert('RGBA')
                    draw_image(composition,
                               item_image,
                               [hero_x + hero_width + (i + 1) * item_padding + i * item_width,
                                hero_y[player['player_slot']] + j * (item_height + item_padding)],
                               [None, item_height])
            # Draw icons
            sword_image = Image.open(os.path.join(self.assets_root, 'icons', 'sword.png')).convert('RGBA')
            sword_image = sword_image.resize([int(item_height / 2), int(item_height / 2)], Image.LANCZOS)
            in_place_sword = Image.new('RGBA', (composition.size[0], composition.size[1]))
            in_place_sword.paste(sword_image,
                                 box=[hero_x + hero_width + 3 * (item_width + item_padding + kda_padding_x),
                                      hero_y[player['player_slot']] + item_height + 15],
                                 mask=sword_image)
            composition = Image.alpha_composite(composition, in_place_sword)

            # Draw kda skull
            skull_image = Image.open(os.path.join(self.assets_root, 'icons', 'skull.png')).convert('RGBA')
            skull_image = skull_image.resize([int(item_height / 2), int(item_height / 2)], Image.LANCZOS)
            in_place_skull = Image.new('RGBA', (composition.size[0], composition.size[1]))
            in_place_skull.paste(skull_image,
                                 box=[hero_x + hero_width + 3 * (item_width + item_padding + kda_padding_x),
                                      hero_y[player['player_slot']] + 12],
                                 mask=skull_image)
            composition = Image.alpha_composite(composition, in_place_skull)

        # Draw colors
        image_draw = ImageDraw.Draw(composition)
        for player in game_json['players']:
            image_draw.rectangle([hero_x - hero_color_width,
                                  hero_y[player['player_slot']],
                                  hero_x,
                                  hero_y[player['player_slot']] + hero_height - 1],
                                 fill=hero_color[player['player_slot']])
        # Draw player names & pseudo
        for player in game_json['players']:
            pro_player = next((pro_player for pro_player in players if pro_player.account_id == player['account_id']),
                              None)
            player_name_font = rift_player_nickname
            if pro_player is None:
                name = '-'
                nickname = '-'
            else:
                name = pro_player.name
                nickname = pro_player.nickname
                if not len(nickname) == len(nickname.encode()):
                    player_name_font = noto_cjk_player_nickname

            draw_text_left_align(image_draw, [hero_x + player_name_x_padding,
                                              hero_y[player['player_slot']] + player_name_y_padding],
                                 nickname, player_name_font, fill=self.colors['white'])
            draw_text_left_align(image_draw, [hero_x + player_name_x_padding,
                                              hero_y[player[
                                                  'player_slot']] + player_name_y_padding + player_nickname_y_padding],
                                 name, rift_player_name, fill=self.colors['white'])
            kda = "{0}/{1}/{2}".format(player['kills'], player['deaths'], player['assists'])
            image_draw.text([hero_x + hero_width + 3 * (item_width + item_padding + kda_padding_x) + int(
                item_height / 2) + 3 * item_padding,
                             hero_y[player['player_slot']]],
                            text=kda, font=rift_kda, fill=self.colors['white'])
            image_draw.text([hero_x + hero_width + 3 * (item_width + item_padding + kda_padding_x) + int(
                item_height / 2) + 3 * item_padding,
                             hero_y[player['player_slot']] + item_height + item_padding],
                            text=str(player['hero_damage']), font=rift_dmg, fill=self.colors['white'])

        # Draw graph
        radiant_gold_adv = game_json['radiant_gold_adv']
        radiant_xp_adv = game_json['radiant_xp_adv']
        graph_start_x = 875
        graph_end_x = 1800
        graph_y = 400
        graph_width = 4
        graph_graduation_x = 10

        gold_xp_max = 0
        for item in chain(radiant_gold_adv, radiant_xp_adv):
            if abs(item) > gold_xp_max: gold_xp_max = abs(item)
        gold_xp_max = int((gold_xp_max - gold_xp_max % 1000) / 1000 + 1)
        duration = math.ceil(game_json['duration'] / 60)
        graph_x_step = math.floor((graph_end_x - graph_start_x) / duration)
        graph_y_step = math.floor(graph_y / gold_xp_max)

        image_draw.line([graph_start_x, 540 - int(graph_width / 2), graph_end_x, 540 - int(graph_width / 2)],
                        fill=self.colors['white'], width=graph_width)
        image_draw.line(
            [graph_start_x - int(graph_width / 2), 540 - graph_y, graph_start_x - int(graph_width / 2), 540 + graph_y],
            fill=self.colors['white'], width=graph_width)
        i = 5
        while i < gold_xp_max:
            image_draw.line([graph_start_x,
                             540 + graph_y_step * i,
                             graph_end_x,
                             540 + graph_y_step * i],
                            fill=self.colors['grey'], width=1)
            image_draw.line([graph_start_x,
                             540 - graph_y_step * i,
                             graph_end_x,
                             540 - graph_y_step * i],
                            fill=self.colors['grey'], width=1)
            i += 5
        i = 5
        while i < duration:
            image_draw.line([graph_start_x + i * graph_x_step,
                             540 - graph_graduation_x - 2,
                             graph_start_x + i * graph_x_step,
                             540 + graph_graduation_x - 1],
                            fill=self.colors['white'], width=graph_width)
            i += 5
        for i in range(1, duration):
            image_draw.line([graph_start_x + (i - 1) * graph_x_step,
                             540 - int(graph_y_step * (radiant_xp_adv[i - 1] / 1000)),
                             graph_start_x + i * graph_x_step,
                             540 - int(graph_y_step * (radiant_xp_adv[i] / 1000))], fill=self.colors['blue'], width=6)
            image_draw.line([graph_start_x + (i - 1) * graph_x_step,
                             540 - int(graph_y_step * (radiant_gold_adv[i - 1] / 1000)),
                             graph_start_x + i * graph_x_step,
                             540 - int(graph_y_step * (radiant_gold_adv[i] / 1000))], fill=self.colors['yellow'],
                            width=6)

        for objectif in game_json['objectives']:
            objectif_x = 0
            objectif_y = 0
            image = 'error'
            if objectif['type'] in ['CHAT_MESSAGE_COURIER_LOST', 'building_kill', 'CHAT_MESSAGE_ROSHAN_KILL']:
                objectif_x = graph_start_x + int(graph_x_step * objectif['time'] / 60)
                if objectif['type'] == 'CHAT_MESSAGE_COURIER_LOST':
                    image = 'chick_kill'
                    if objectif['team'] == 2:
                        objectif_y = 540 - graph_y - 35
                    else:
                        objectif_y = 540 + graph_y + 35
                elif objectif['type'] == 'CHAT_MESSAGE_ROSHAN_KILL':
                    image = 'roshan_kill'
                    if objectif['team'] == 2:
                        objectif_y = 540 - graph_y - 35
                    else:
                        objectif_y = 540 + graph_y + 35
                else:
                    if 'badguys' in objectif['key']:
                        objectif_y = 540 - graph_y - 35
                    else:
                        objectif_y = 540 + graph_y + 35
                    if 'tower' in objectif['key']:
                        image = 'tower_kill'
                    elif 'healers' in objectif['key']:
                        image = 'shrine_kill'
                    elif 'melee_rax' in objectif['key']:
                        image = 'rax_kill'
            if image == 'error':
                continue

            image_icon = Image.open(os.path.join(self.assets_root, 'icons', image + '.png')).convert('RGBA')
            composition = draw_image_centered(composition, image_icon, [objectif_x, objectif_y], [35, 35])
        for player in game_json['players']:
            for item_purchase in player['purchase_log']:
                if item_purchase['key'] in ['black_king_bar', 'blink', 'sheepstick', 'silver_edge', 'refresher',
                                            'orchid']:
                    if player['player_slot'] > 100:
                        item_y = 540 + graph_y
                    else:
                        item_y = 540 - graph_y
                    item_x = graph_start_x + int(graph_x_step * item_purchase['time'] / 60)

                    image_icon = Image.open(
                        os.path.join(self.assets_root, 'icons', 'item_' + item_purchase['key'] + '.png')).convert(
                        'RGBA')
                    composition = draw_image_centered(composition, image_icon, [item_x, item_y], [35, 35])

        # Draw titles
        image_draw = ImageDraw.Draw(composition)
        radiant_team = '?'
        dire_team = '?'
        radiant_team_info = next((team for team in teams if team.id == game_json['radiant_team_id']), None)
        if radiant_team_info is not None:
            radiant_team = radiant_team_info.name
        dire_team_info = next((team for team in teams if team.id == game_json['dire_team_id']), None)
        if dire_team_info is not None:
            dire_team = dire_team_info.name

        radiant_color = self.colors['ti_green']
        dire_color = self.colors['ti_green']
        laurels_icon = Image.open(os.path.join(self.assets_root, 'icons', 'laurels.png')).convert('RGBA')
        if game_json['radiant_win']:
            laurels_x = [int((graph_start_x + graph_end_x - image_draw.textsize(radiant_team, rift_team)[0]) / 2) - 40,
                         int((graph_start_x + graph_end_x + image_draw.textsize(radiant_team, rift_team)[0]) / 2) + 40]
            laurels_y = 45
            dire_color = self.colors['grey']
        else:
            laurels_x = [int((graph_start_x + graph_end_x - image_draw.textsize(dire_team, rift_team)[0]) / 2) - 40,
                         int((graph_start_x + graph_end_x + image_draw.textsize(dire_team, rift_team)[0]) / 2) + 40]
            laurels_y = 1035
            radiant_color = self.colors['grey']
        draw_text_outlined_center_align(image_draw, [int((graph_start_x + graph_end_x) / 2), 15], radiant_team,
                                        font=rift_team, fill=radiant_color, outline_fill=self.colors['black'],
                                        outline_width=4)
        draw_text_outlined_center_align(image_draw, [int((graph_start_x + graph_end_x) / 2), 1005], dire_team,
                                        font=rift_team, fill=dire_color, outline_fill=self.colors['black'],
                                        outline_width=4)

        composition = draw_image_centered(composition, laurels_icon, [laurels_x[0], laurels_y], [40, 40])
        composition = draw_image_centered(composition, laurels_icon, [laurels_x[1], laurels_y], [40, 40])

        composition.save(generated_path)
