import os

from PIL import Image, ImageDraw, ImageColor, ImageFont

from models import DotaProTeam, GroupStage
from image_generation.helpers import draw_text_outlined_center_align, draw_alpha_rectangle, \
    draw_text_center_align, draw_image_advanced


class GroupStageMixin:

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
