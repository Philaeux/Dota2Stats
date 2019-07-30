import time
import os
import shutil
import math
import requests
import json

from tornado_sqlalchemy import as_future
from tornado.gen import multi
from PIL import Image, ImageDraw, ImageColor, ImageFont
from image_manipulation import draw_text_outlined, draw_text_outlined_center_align, draw_alpha_rectangle, \
    draw_text_center_align, draw_text_left_align, draw_image_advanced, draw_image
from models import DotaProPlayer, DotaHeroes, DotaItem, DotaProTeam, GroupStage


class ImageGenerator:

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
        self.session = None
        self.assets_root = assets_root
        self.generated_root = os.path.join(assets_root, "generated")
        self.teams_data = os.path.join(assets_root, "teams")

    def generate_static(self, team_id):
        generated_path = os.path.join(self.generated_root, "static_teams-" + team_id + ".png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        source_path = os.path.join(self.teams_data, team_id, "static_teams-" + team_id + ".png")
        if os.path.exists(source_path):
            shutil.copy(source_path, generated_path)

    def generate_group_stage(self):
        generated_path = os.path.join(self.generated_root, "group_stage.png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        # Generate image
        composition = Image.open(os.path.join(self.assets_root, 'background2.png')).convert('RGBA')
        image_draw = ImageDraw.Draw(composition)

        rift_bold_title = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 120)
        rift_regular_sub = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 58)
        rift_bold_sub = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 58)
        logo_array = {
            15: {'offset': [75, 45], 'size': [None, 75], 'suffix': '-horiz'},
            36: {'offset': [75, 45], 'size': [None, 70], 'suffix': ''},
            39: {'offset': [75, 45], 'size': [None, 70], 'suffix': ''},
            2163: {'offset': [75, 45], 'size': [None, 85], 'suffix': '-solid'},
            111474: {'offset': [75, 45], 'size': [None, 75], 'suffix': ''},
            350190: {'offset': [75, 45], 'size': [None, 70], 'suffix': ''},
            543897: {'offset': [75, 45], 'size': [None, 75], 'suffix': ''},
            726228: {'offset': [75, 45], 'size': [None, 70], 'suffix': ''},
            1375614: {'offset': [75, 45], 'size': [None, 65], 'suffix': ''},
            1838315: {'offset': [75, 45], 'size': [None, 55], 'suffix': '-silver'},
            1883502: {'offset': [75, 45], 'size': [None, 65], 'suffix': ''},
            2108395: {'offset': [75, 45], 'size': [None, 70], 'suffix': ''},
            2586976: {'offset': [75, 45], 'size': [None, 70], 'suffix': ''},
            2626685: {'offset': [75, 45], 'size': [None, 65], 'suffix': ''},
            5065748: {'offset': [75, 45], 'size': [None, 70], 'suffix': ''},
            6209804: {'offset': [75, 45], 'size': [None, 70], 'suffix': ''},
            6214973: {'offset': [75, 45], 'size': [None, 65], 'suffix': ''},
            6666989: {'offset': [75, 45], 'size': [None, 72], 'suffix': ''},
        }

        draw_text_outlined_center_align(image_draw, [480, 45], 'Groupe A', font=rift_bold_title,
                                        fill=self.colors['ti_purple'], outline_fill=self.colors['black'],
                                        outline_width=5)
        draw_text_outlined_center_align(image_draw, [1440, 45], 'Groupe B', font=rift_bold_title,
                                        fill=self.colors['ti_purple'], outline_fill=self.colors['black'],
                                        outline_width=5)
        # Draw
        rectangle_height = 90
        rectangle_start = 215
        rectangle_group_x_start = [100, 1060]
        rectangle_group_x_end = [860, 1820]
        rectangle_padding = 7

        group_a_y = rectangle_start
        group_b_y = rectangle_start
        team_offset = [150, 10]
        win_offset = [615, 10]
        loses_offset = [705, 10]

        teams = {}
        for team in self.session.query(DotaProTeam).all():
            teams[team.id] = team.name
        for team in self.session.query(GroupStage).order_by(GroupStage.group_number, GroupStage.position).all():
            if team.group_number == 1:
                current_team_x_start = rectangle_group_x_start[0]
                current_team_x_end = rectangle_group_x_end[0]
                current_team_y = group_a_y
            else:
                current_team_x_start = rectangle_group_x_start[1]
                current_team_x_end = rectangle_group_x_end[1]
                current_team_y = group_b_y

            composition = draw_alpha_rectangle(composition,
                                               [current_team_x_start,
                                                current_team_y + rectangle_padding,
                                                current_team_x_end,
                                                current_team_y + rectangle_height - rectangle_padding],
                                               fill=self.colors[team.color], alpha=0.5)
            image_draw = ImageDraw.Draw(composition)

            image_draw.text([current_team_x_start + team_offset[0], current_team_y + team_offset[1]],
                            teams[team.team_id], font=rift_regular_sub, fill=self.colors['white'])
            draw_text_center_align(image_draw, [current_team_x_start + win_offset[0], current_team_y + win_offset[1]],
                                   str(team.wins), font=rift_bold_sub, fill=self.colors['white'])
            draw_text_center_align(image_draw, [current_team_x_start + loses_offset[0], current_team_y + loses_offset[1]],
                                   str(team.loses), font=rift_bold_sub, fill=self.colors['white'])

            # Draw logo if image present
            if team.team_id in logo_array:
                logo_path = os.path.join(self.teams_data,
                                         str(team.team_id),
                                         "logo-" + str(team.team_id) + logo_array[team.team_id]["suffix"] + ".png")
                if os.path.exists(logo_path):
                    logo = Image.open(logo_path).convert('RGBA')
                    composition = draw_image_advanced(composition, logo,
                                                      [current_team_x_start + logo_array[team.team_id]['offset'][0],
                                                       current_team_y + logo_array[team.team_id]['offset'][1]],
                                                      logo_array[team.team_id]['size'],
                                                      1)
            if team.group_number == 1:
                group_a_y += rectangle_height
            else:
                group_b_y += rectangle_height
        composition.save(generated_path)

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
        rift_player_name = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 26)
        rift_kda = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 32)
        rift_dmg = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 32)

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
        hero_width = int(256*hero_height/144)
        hero_y_padding = 10
        item_padding = 4
        item_height = int((hero_height-item_padding)/2)
        item_width = int(88*item_height/64)
        player_name_x_padding = -40
        player_name_y_padding = 0
        player_nickname_y_padding = 50
        kda_padding_x = 5
        hero_y = {0: hero_y_side_padding,
                  1: hero_y_side_padding + hero_height + hero_y_padding,
                  2: hero_y_side_padding + 2*(hero_height + hero_y_padding),
                  3: hero_y_side_padding + 3*(hero_height + hero_y_padding),
                  4: hero_y_side_padding + 4*(hero_height + hero_y_padding),
                  128: 1080 - hero_y_side_padding - hero_height*5 - hero_y_padding*4,
                  129: 1080 - hero_y_side_padding - hero_height*4 - hero_y_padding*3,
                  130: 1080 - hero_y_side_padding - hero_height*3 - hero_y_padding*2,
                  131: 1080 - hero_y_side_padding - hero_height*2 - hero_y_padding,
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

        for player in players:
            print(player.name)
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
            for j in range(0, 2):
                for i in range(0, 3):
                    key = 'item_{0}'.format(j * 3 + i)
                    if player[key] != 0:
                        item = next((item for item in items if item.id == player[key]), None)
                        if item is None:
                            short_name = 'error'
                        else:
                            short_name = item.short_name
                        item_image = Image.open(os.path.join(self.assets_root, 'dota', 'item_rectangle',
                                                             short_name + '.png')).convert('RGBA')
                    else:
                        item_image = Image.open(os.path.join(self.assets_root, 'dota', 'item_rectangle', 'empty.png')) \
                            .convert('RGBA')
                    draw_image(composition,
                               item_image,
                               [hero_x + hero_width + (i + 1) * item_padding + i * item_width,
                                hero_y[player['player_slot']] + j * (item_height + item_padding)],
                               [None, item_height])

        # Draw colors
        image_draw = ImageDraw.Draw(composition)
        for player in game_json['players']:
            image_draw.rectangle([hero_x-hero_color_width,
                                  hero_y[player['player_slot']],
                                  hero_x,
                                  hero_y[player['player_slot']] + hero_height-1],
                                 fill=hero_color[player['player_slot']])
        # Draw player names & pseudo
        for player in game_json['players']:
            print(len(players))
            pro_player = next((pro_player for pro_player in players if pro_player.account_id == player['account_id']), None)
            if pro_player is None:
                name = '-'
                nickname = '-'
            else:
                name = pro_player.name
                nickname = pro_player.nickname

            draw_text_left_align(image_draw, [hero_x + player_name_x_padding,
                                              hero_y[player['player_slot']] + player_name_y_padding],
                                 nickname, rift_player_nickname, fill=self.colors['white'])
            draw_text_left_align(image_draw, [hero_x + player_name_x_padding,
                                              hero_y[player[
                                                  'player_slot']] + player_name_y_padding + player_nickname_y_padding],
                                 name, rift_player_name, fill=self.colors['white'])
            kda = "{0}/{1}/{2}".format(player['kills'], player['deaths'], player['assists'])
            image_draw.text([hero_x + hero_width + 3 * (item_width + item_padding + kda_padding_x) + int(
                item_height / 2) + item_padding,
                             hero_y[player['player_slot']]],
                            text=kda, font=rift_kda, fill=self.colors['white'])
            image_draw.text([hero_x + hero_width + 3 * (item_width + item_padding + kda_padding_x) + int(
                item_height / 2) + item_padding,
                             hero_y[player['player_slot']] + item_height + item_padding],
                            text=str(player['hero_damage']), font=rift_dmg, fill=self.colors['orange'])

        composition.save(generated_path)
