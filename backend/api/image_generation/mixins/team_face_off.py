import decimal
import os
import types
import time
from PIL import Image, ImageDraw, ImageFont
from tornado_sqlalchemy import as_future
from tornado.gen import multi
from sqlalchemy import desc

from image_generation.helpers import draw_image, draw_image_advanced, draw_text_center_align
from models import DotaHeroes, DotaJoinGlobalTeam, DotaJoinGlobalTeamHero


class TeamFaceOffMixin:

    async def generate_team_face_off(self, team_1, team_2):
        # Delete previous image
        generated_path = os.path.join(self.generated_root, "team_face_off-" + str(team_1) + "-" + str(team_2) + ".png")
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

        if team_stats[0] is None or team_stats[1] is None:
            image_draw.text([100, 100], str(time.time()), font=rift_title, fill=self.colors['light_red'])
            image_draw.text([100, 200], "NO STAT FOR DIS TEAMS", font=rift_title, fill=self.colors['light_red'])
            composition.save(generated_path)
            return

        # Top Picks & Success
        hero_top_wr = await multi([
            as_future(self.session.query(DotaJoinGlobalTeamHero)
                      .filter(DotaJoinGlobalTeamHero.team_id == team_stats[0].team_id,
                              DotaJoinGlobalTeamHero.nb_pick >= 4)
                      .order_by(desc(DotaJoinGlobalTeamHero.mean_is_win)).limit(5).all),
            as_future(self.session.query(DotaJoinGlobalTeamHero)
                      .filter(DotaJoinGlobalTeamHero.team_id == team_stats[1].team_id,
                              DotaJoinGlobalTeamHero.nb_pick >= 4)
                      .order_by(desc(DotaJoinGlobalTeamHero.mean_is_win)).limit(5).all)
        ])
        hero_top_pick = await multi([
            as_future(self.session.query(DotaJoinGlobalTeamHero)
                      .filter(DotaJoinGlobalTeamHero.team_id == team_stats[0].team_id)
                      .order_by(desc(DotaJoinGlobalTeamHero.nb_pick)).limit(5).all),
            as_future(self.session.query(DotaJoinGlobalTeamHero)
                      .filter(DotaJoinGlobalTeamHero.team_id == team_stats[1].team_id)
                      .order_by(desc(DotaJoinGlobalTeamHero.nb_pick)).limit(5).all)
        ])
        hero_top_ban_against = await multi([
            as_future(self.session.query(DotaJoinGlobalTeamHero)
                      .filter(DotaJoinGlobalTeamHero.team_id == team_stats[0].team_id)
                      .order_by(desc(DotaJoinGlobalTeamHero.nb_ban_against)).limit(3).all),
            as_future(self.session.query(DotaJoinGlobalTeamHero)
                      .filter(DotaJoinGlobalTeamHero.team_id == team_stats[1].team_id)
                      .order_by(desc(DotaJoinGlobalTeamHero.nb_ban_against)).limit(3).all)
        ])

        hero_height = 90
        hero_width = int(256 * hero_height / 144)
        hero_padding = 5
        hero_x_picks = [0, 0]
        hero_x_picks[0] = 40
        hero_x_picks[1] = 1920 - hero_x_picks[0] - 5*hero_width - 4*hero_padding
        hero_y_text_padding = image_draw.textsize('1', rift_text)[1]
        rows = [0, 0, 0, 0, 0, 0]
        rows[0] = 170
        rows[1] = rows[0] + hero_height + 2*hero_y_text_padding + 8*hero_padding
        rows[2] = rows[1] + hero_height + 2*hero_y_text_padding + 8*hero_padding
        rows[3] = rows[2] + hero_height + hero_y_text_padding + 8*hero_padding + 10
        rows[4] = rows[3] + 120
        rows[5] = rows[2]
        hero_x_bans = [
            hero_x_picks[0] + 2*(hero_width + hero_padding),
            hero_x_picks[1]
        ]
        hero_x_duration = [180, 330]
        games_x = 775
        logo_x = 700

        # Logo
        logo_array = {
            15: {'suffix': '-horiz'},
            36: {'suffix': ''},
            39: {'suffix': ''},
            2163: {'suffix': '-solid'},
            111474: {'suffix': ''},
            350190: {'suffix': ''},
            543897: {'suffix': ''},
            726228: {'suffix': ''},
            1838315: {'suffix': '-silver'},
            1883502: {'suffix': '-ti9'},
            2108395: {'suffix': ''},
            2586976: {'suffix': ''},
            2626685: {'suffix': ''},
            2672298: {'suffix': ''},
            6209804: {'suffix': ''},
            6214538: {'suffix': ''},
            6214973: {'suffix': ''},
            7203342: {'suffix': ''},
        }
        logo_path = os.path.join(self.teams_data, str(team_1), "logo-" + str(team_1) + logo_array[team_1]["suffix"] + ".png")
        if os.path.exists(logo_path):
            logo = Image.open(logo_path).convert('RGBA')
            composition = draw_image_advanced(composition, logo,
                                              [960-logo_x, 930],
                                              [None, 300],
                                              0.7)
        logo_path = os.path.join(self.teams_data, str(team_2), "logo-" + str(team_2) + logo_array[team_2]["suffix"] + ".png")
        if os.path.exists(logo_path):
            logo = Image.open(logo_path).convert('RGBA')
            composition = draw_image_advanced(composition, logo,
                                              [960+logo_x, 930],
                                              [None, 300],
                                              0.7)

        # Left is reverse
        for i in range(0, 2):
            for j in range(0, len(hero_top_pick[i])):
                hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                     'hero_rectangle', hero_top_pick[i][j].hero_short_name + '.png')).convert('RGBA')
                draw_image(composition, hero_image, [hero_x_picks[i] + (1-i)*(len(hero_top_pick[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding),
                                                          rows[0]], [None, hero_height])
            for j in range(0, len(hero_top_wr[i])):
                hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                     'hero_rectangle', hero_top_wr[i][j].hero_short_name + '.png')).convert('RGBA')
                draw_image(composition, hero_image, [hero_x_picks[i] + (1-i)*(len(hero_top_wr[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding),
                                                          rows[1]], [None, hero_height])
            for j in range(0, len(hero_top_ban_against[i])):
                hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                     'hero_rectangle', hero_top_ban_against[i][j].hero_short_name + '.png')).convert('RGBA')
                draw_image(composition, hero_image, [hero_x_bans[i] + (1-i)*(len(hero_top_ban_against[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding),
                                                          rows[2]], [None, hero_height])

        image_draw = ImageDraw.Draw(composition)
        draw_text_center_align(image_draw, [960, rows[0] + 15], 'PICKS', font=rift_middle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [960, rows[1] + 15], 'SUCCESS', font=rift_middle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [960, rows[2] - 5], 'BAN', font=rift_middle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [960, rows[2] + 40], 'TARGETS', font=rift_middle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [960, rows[3]], 'DURATION', font=rift_middle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [960 - hero_x_duration[0], rows[3]],
                               self.duration_to_string(team_stats[0].win_duration), font=rift_text,
                               fill=self.colors['ti_green'])
        draw_text_center_align(image_draw, [960 - hero_x_duration[1], rows[3]],
                               self.duration_to_string(team_stats[0].lose_duration), font=rift_text,
                               fill=self.colors['light_red'])
        draw_text_center_align(image_draw, [960 + hero_x_duration[0], rows[3]],
                               self.duration_to_string(team_stats[1].win_duration), font=rift_text,
                               fill=self.colors['ti_green'])
        draw_text_center_align(image_draw, [960 + hero_x_duration[1], rows[3]],
                               self.duration_to_string(team_stats[1].lose_duration), font=rift_text,
                               fill=self.colors['light_red'])

        draw_text_center_align(image_draw, [960, rows[4]], 'BOUNTIES', font=rift_middle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [960 - hero_x_duration[0], rows[4]],
                               '{0:.1f} %'.format(team_stats[0].mean_pct_bounty * 100), font=rift_text,
                               fill=self.colors['yellow'])
        draw_text_center_align(image_draw, [960 + hero_x_duration[0], rows[4]],
                               '{0:.1f} %'.format(team_stats[1].mean_pct_bounty * 100), font=rift_text,
                               fill=self.colors['yellow'])
        draw_text_center_align(image_draw, [480, 30], '{0}'.format(team_stats[0].team_name), font=rift_title,
                               fill=self.colors['ti_purple'])
        draw_text_center_align(image_draw, [1440, 30], '{0}'.format(team_stats[1].team_name), font=rift_title,
                               fill=self.colors['ti_purple'])
        draw_text_center_align(image_draw, [960 - games_x, rows[5]], 'GAMES', font=rift_middle,
                               fill=self.colors['white'])
        draw_text_center_align(image_draw, [960 - games_x, rows[5] + 50],
                               '{0:.0f}'.format(team_stats[0].nb_match), font=rift_text,
                               fill=self.colors['white'])
        draw_text_center_align(image_draw, [960 + games_x, rows[5]], 'GAMES', font=rift_middle,
                               fill=self.colors['white'])
        draw_text_center_align(image_draw, [960 + games_x, rows[5] + 50],
                               '{0:.0f}'.format(team_stats[1].nb_match), font=rift_text,
                               fill=self.colors['white'])

        for i in range(0, 2):
            for j in range(0, len(hero_top_pick[i])):
                draw_text_center_align(image_draw,
                                            [hero_x_picks[i] + (1-i)*(len(hero_top_pick[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[0] + hero_height],
                                            '{0:.0f}'.format(hero_top_pick[i][j].nb_pick),
                                            font=rift_text,
                                            fill=self.colors['white'])
                draw_text_center_align(image_draw,
                                            [hero_x_picks[i] + (1-i)*(len(hero_top_pick[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[0] + hero_height + hero_y_text_padding],
                                            '{0:.1f} %'.format(100*hero_top_pick[i][j].mean_is_win),
                                            font=rift_text,
                                            fill=self.colors['white'])
            for j in range(0, len(hero_top_wr[i])):
                draw_text_center_align(image_draw,
                                            [hero_x_picks[i] + (1-i)*(len(hero_top_wr[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[1] + hero_height],
                                            '{0:.1f} %'.format(100*hero_top_wr[i][j].mean_is_win),
                                            font=rift_text,
                                            fill=self.colors['white'])
                draw_text_center_align(image_draw,
                                            [hero_x_picks[i] + (1-i)*(len(hero_top_wr[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[1] + hero_height + hero_y_text_padding],
                                            '{0:.0f}'.format(hero_top_wr[i][j].nb_pick),
                                            font=rift_text,
                                            fill=self.colors['white'])
            for j in range(0, len(hero_top_ban_against[i])):
                draw_text_center_align(image_draw,
                                            [hero_x_bans[i] + (1-i)*(len(hero_top_ban_against[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[2] + hero_height],
                                            '{0:.0f}'.format(hero_top_ban_against[i][j].nb_ban_against),
                                            font=rift_text,
                                            fill=self.colors['white'])

        composition.save(generated_path)
