import os
import types
from PIL import Image, ImageDraw, ImageFont
from tornado_sqlalchemy import as_future
from tornado.gen import multi

from image_generation.helpers import draw_image, draw_image_advanced, draw_text_center_align
from models import DotaProTeam, DotaHeroes

class TeamFaceOffMixin:

    async def generate_team_face_off(self, team_1, team_2):
        # Get Data
        teams = await multi([
            as_future(self.session.query(DotaProTeam).filter(DotaProTeam.id == int(team_1)).one_or_none),
            as_future(self.session.query(DotaProTeam).filter(DotaProTeam.id == int(team_2)).one_or_none)
        ])
        if teams[0] is None or teams[1] is None:
            return

        # team_stats = await multi([as_future(self.session.query(DotaStatTounamentTeam).filter(DotaStatTounamentTeam.tn_id == tournament_id,
        #                                                                                      DotaStatTounamentTeam.team_id == teams[0].id).one_or_none),
        #                           as_future(self.session.query(DotaStatTounamentTeam).filter(DotaStatTounamentTeam.tn_id == tournament_id,
        #                                                                                      DotaStatTounamentTeam.team_id == teams[1].id).one_or_none)])

        team_stats = [types.SimpleNamespace(win_duration=100, lose_duration=100, mean_pct_bounty=0.44, nb_match=10),
                      types.SimpleNamespace(win_duration=100, lose_duration=100, mean_pct_bounty=0.44, nb_match=10)]
        heroes = await as_future(self.session.query(DotaHeroes).all)

        # Top Picks & Success
        picks = [[], []]
        picks_stat = [[], []]
        successful = [[], []]
        successful_stat = [[], []]
        bans = [[], []]
        bans_stat = [[], []]
        for i in range(0, 2):
            # for hero_stat in await as_future(self.session.query(DotaStatTounamentTeamHero).filter(DotaStatTounamentTeamHero.id_tn==tournament_id, DotaStatTounamentTeamHero.team_id == teams[i].id) .order_by(desc(DotaStatTounamentTeamHero.nb_pick)).limit(5).all()):
            for hero_stat in [types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=8, nb_pick=8, mean_is_win=0.88),types.SimpleNamespace(hero_id=7, nb_pick=7, mean_is_win=0.77),types.SimpleNamespace(hero_id=6, nb_pick=6, mean_is_win=0.66),types.SimpleNamespace(hero_id=5, nb_pick=5, mean_is_win=0.55)]:
                hero = next((hero for hero in heroes if hero.id == int(hero_stat.hero_id)), None)
                if hero is not None:
                    picks[i].append(hero)
                    picks_stat[i].append(hero_stat)
            #for hero_stat in db.session.query(DotaStatTounamentTeamHero).filter(DotaStatTounamentTeamHero.id_tn==tournament_id, DotaStatTounamentTeamHero.team_id == teams[i].id, DotaStatTounamentTeamHero.nb_pick >= 4).order_by(desc(DotaStatTounamentTeamHero.mean_is_win)).limit(5).all():
            for hero_stat in [types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=8, nb_pick=8, mean_is_win=0.88),types.SimpleNamespace(hero_id=7, nb_pick=7, mean_is_win=0.77),types.SimpleNamespace(hero_id=6, nb_pick=6, mean_is_win=0.66),types.SimpleNamespace(hero_id=5, nb_pick=5, mean_is_win=0.55)]:
                hero = next((hero for hero in heroes if hero.id == int(hero_stat.hero_id)), None)
                if hero is not None:
                    successful[i].append(hero)
                    successful_stat[i].append(hero_stat)
            #for hero_stat in db.session.query(DotaStatTounamentTeamHero).filter(DotaStatTounamentTeamHero.id_tn==tournament_id, DotaStatTounamentTeamHero.team_id == teams[i].id).order_by(desc(DotaStatTounamentTeamHero.nb_ban_against)).limit(3).all():
            for hero_stat in [types.SimpleNamespace(hero_id=5, nb_ban_against=5, mean_is_win=0.55),types.SimpleNamespace(hero_id=4, nb_ban_against=4, mean_is_win=0.44),types.SimpleNamespace(hero_id=3, nb_ban_against=3, mean_is_win=0.33)]:
                hero = next((hero for hero in heroes if hero.id == int(hero_stat.hero_id)), None)
                if hero is not None:
                    bans[i].append(hero)
                    bans_stat[i].append(hero_stat)

        # Delete previous image
        generated_path = os.path.join(self.generated_root, "team_face_off-" + str(team_1) + "-" + str(team_2) + ".png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        # Generate image
        composition = Image.open(os.path.join(self.assets_root, 'background3.png')).convert('RGBA')
        image_draw = ImageDraw.Draw(composition)
        rift_title = ImageFont.truetype(os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 72)
        rift_middle = ImageFont.truetype(os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 48)
        rift_text = ImageFont.truetype(os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 50)

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
        logo_path = os.path.join(self.teams_data, str(team_1), "logo-" + str(team_1) + ".png")
        if os.path.exists(logo_path):
            logo = Image.open(logo_path).convert('RGBA')
            composition = draw_image_advanced(composition, logo,
                                              [960-logo_x, 930],
                                              [None, 300],
                                              0.7)
        logo_path = os.path.join(self.teams_data, str(team_2), "logo-" + str(team_2) + ".png")
        if os.path.exists(logo_path):
            logo = Image.open(logo_path).convert('RGBA')
            composition = draw_image_advanced(composition, logo,
                                              [960+logo_x, 930],
                                              [None, 300],
                                              0.7)

        # Left is reverse
        for i in range(0, 2):
            for j in range(0, len(picks[i])):
                hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                     'hero_rectangle', picks[i][j].short_name + '.png')).convert('RGBA')
                draw_image(composition, hero_image, [hero_x_picks[i] + (1-i)*(len(picks[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding),
                                                          rows[0]], [None, hero_height])
            for j in range(0, len(successful[i])):
                hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                     'hero_rectangle', successful[i][j].short_name + '.png')).convert('RGBA')
                draw_image(composition, hero_image, [hero_x_picks[i] + (1-i)*(len(successful[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding),
                                                          rows[1]], [None, hero_height])
            for j in range(0, len(bans[i])):
                hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                     'hero_rectangle', bans[i][j].short_name + '.png')).convert('RGBA')
                draw_image(composition, hero_image, [hero_x_bans[i] + (1-i)*(len(bans[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding),
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
        draw_text_center_align(image_draw, [480, 30], '{0}'.format(teams[0].name), font=rift_title,
                               fill=self.colors['ti_green'])
        draw_text_center_align(image_draw, [1440, 30], '{0}'.format(teams[1].name), font=rift_title,
                               fill=self.colors['ti_green'])
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
            for j in range(0, len(picks[i])):
                draw_text_center_align(image_draw,
                                            [hero_x_picks[i] + (1-i)*(len(picks[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[0] + hero_height],
                                            '{0:.0f}'.format(picks_stat[i][j].nb_pick),
                                            font=rift_text,
                                            fill=self.colors['white'])
                draw_text_center_align(image_draw,
                                            [hero_x_picks[i] + (1-i)*(len(picks[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[0] + hero_height + hero_y_text_padding],
                                            '{0:.1f} %'.format(100*picks_stat[i][j].mean_is_win),
                                            font=rift_text,
                                            fill=self.colors['white'])
            for j in range(0, len(successful[i])):
                draw_text_center_align(image_draw,
                                            [hero_x_picks[i] + (1-i)*(len(successful[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[1] + hero_height],
                                            '{0:.1f} %'.format(100*successful_stat[i][j].mean_is_win),
                                            font=rift_text,
                                            fill=self.colors['white'])
                draw_text_center_align(image_draw,
                                            [hero_x_picks[i] + (1-i)*(len(successful[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[1] + hero_height + hero_y_text_padding],
                                            '{0:.0f}'.format(successful_stat[i][j].nb_pick),
                                            font=rift_text,
                                            fill=self.colors['white'])
            for j in range(0, len(bans[i])):
                draw_text_center_align(image_draw,
                                            [hero_x_bans[i] + (1-i)*(len(bans[i])-j-1)*(hero_width + hero_padding) + i*j*(hero_width + hero_padding) + int(hero_width/2),
                                             rows[2] + hero_height],
                                            '{0:.0f}'.format(bans_stat[i][j].nb_ban_against),
                                            font=rift_text,
                                            fill=self.colors['white'])

        composition.save(generated_path)
