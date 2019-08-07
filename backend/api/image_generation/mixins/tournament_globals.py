import os
import types
import math
from PIL import Image, ImageDraw, ImageFont
from tornado_sqlalchemy import as_future

from models import DotaHeroes
from image_generation.helpers import draw_text_outlined_center_align, draw_image, draw_text_center_align


class TournamentGlobalsMixin:

    async def generate_tournament_globals(self):
        generated_path = os.path.join(self.generated_root, "tournament_globals.png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        # Generate image
        composition = Image.open(os.path.join(self.assets_root, 'background2.png')).convert('RGBA')
        image_draw = ImageDraw.Draw(composition)
        rift_title = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 72)
        rift_text = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_regular.otf'), 72)
        rift_subtitle = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 72)
        draw_text_outlined_center_align(image_draw, [960, 35], 'The International IX', rift_title,
                                        fill=self.colors['ti_purple'], outline_fill=self.colors['black'],
                                        outline_width=4)

        # Get database data
        heroes = await as_future(self.session.query(DotaHeroes).all)

        # Most successful
        successful = []
        successful_stat = []
        # for hero_stat in self.session.query(DotaStatTounamentHero) \
        #         .filter(DotaStatTounamentHero.id_tn==tournament_id, DotaStatTounamentHero.nb_pick!=0, DotaStatTounamentHero.nb_pick >= 5) \
        #         .order_by(desc(DotaStatTounamentHero.mean_is_win)) \
        #         .limit(8) \
        #         .all():
        for hero_stat in [types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99)]:
            hero = next((hero for hero in heroes if hero.id == int(hero_stat.hero_id)), None)
            if hero is not None:
                successful.append(hero)
                successful_stat.append(hero_stat)

        # Side WR
        radian_wr = 0
        dire_wr = 0
        nb_games = 0
        mean_duration_min = 0
        mean_duration_sec = 0
        # stat_tn = self.session.query(DotaStatTournament).filter(DotaStatTournament.id_tn==tournament_id).one_or_none()
        stat_tn = types.SimpleNamespace(nb_match=9, mean_radiant_win=0.45, mean_duration=1000)
        if stat_tn is not None:
            nb_games = int(stat_tn.nb_match)
            radian_wr = stat_tn.mean_radiant_win*100
            dire_wr = 100 - radian_wr
            mean_duration_sec = math.ceil(stat_tn.mean_duration) % 60
            mean_duration_min = int(math.ceil(stat_tn.mean_duration - mean_duration_sec) / 60)

        # Remaining heroes
        not_picked_heroes = []
        # for hero_stat in self.session.query(DotaStatTounamentHero).filter(DotaStatTounamentHero.id_tn==tournament_id, DotaStatTounamentHero.nb_pick==0).all():
        for hero_stat in [types.SimpleNamespace(hero_id=9),types.SimpleNamespace(hero_id=8),types.SimpleNamespace(hero_id=7),types.SimpleNamespace(hero_id=6),types.SimpleNamespace(hero_id=5)]:
            hero = next((hero for hero in heroes if hero.id == int(hero_stat.hero_id)), None)
            if hero is not None:
                not_picked_heroes.append(hero)

        # Top Picks & Bans
        picks = []
        picks_stat = []
        bans = []
        bans_stat = []
        # for hero_stat in self.session.query(DotaStatTounamentHero).filter(DotaStatTounamentHero.id_tn==tournament_id).order_by(desc(DotaStatTounamentHero.nb_pick)).limit(4).all():
        for hero_stat in [types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_pick=9, mean_is_win=0.99)]:
            hero = next((hero for hero in heroes if hero.id == int(hero_stat.hero_id)), None)
            if hero is not None:
                picks.append(hero)
                picks_stat.append(hero_stat)
        # for hero_stat in self.session.query(DotaStatTounamentHero).filter(DotaStatTounamentHero.id_tn==tournament_id).order_by(desc(DotaStatTounamentHero.nb_ban)).limit(3).all():
        for hero_stat in [types.SimpleNamespace(hero_id=9, nb_ban=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_ban=9, mean_is_win=0.99),types.SimpleNamespace(hero_id=9, nb_ban=9, mean_is_win=0.99)]:
            hero = next((hero for hero in heroes if hero.id == int(hero_stat.hero_id)), None)
            if hero is not None:
                bans.append(hero)
                bans_stat.append(hero_stat)

        # Draw everything
        hero_height = 90
        hero_width = int(256*hero_height/144)
        hero_x = 1350
        hero_y_side_padding = 250
        hero_y_padding = 10
        hero_y_bans_padding = 2*hero_height + 2*hero_y_padding
        successful_x_padding = 500
        hero_y = [{0: hero_y_side_padding,
                   1: hero_y_side_padding + hero_height + hero_y_padding,
                   2: hero_y_side_padding + 2*(hero_height + hero_y_padding),
                   3: hero_y_side_padding + 3*(hero_height + hero_y_padding),
                   4: hero_y_side_padding + 4*(hero_height + hero_y_padding),
                   5: hero_y_side_padding + 5*(hero_height + hero_y_padding),
                   6: hero_y_side_padding + 6*(hero_height + hero_y_padding),
                   7: hero_y_side_padding + 7*(hero_height + hero_y_padding)},
                  {0: hero_y_bans_padding + hero_y_side_padding + 3 * (hero_height + hero_y_padding),
                   1: hero_y_bans_padding + hero_y_side_padding + 4 * (hero_height + hero_y_padding),
                   2: hero_y_bans_padding + hero_y_side_padding + 5 * (hero_height + hero_y_padding)}]
        for i in range(0, len(picks)):
            hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                 'hero_rectangle', picks[i].short_name + '.png')).convert('RGBA')
            draw_image(composition, hero_image, [hero_x, hero_y[0][i]], [None, hero_height])
        for i in range(0, len(bans)):
            hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                 'hero_rectangle', bans[i].short_name + '.png')).convert('RGBA')
            draw_image(composition, hero_image, [hero_x, hero_y[1][i]], [None, hero_height])
        for i in range(0, len(successful)):
            hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                 'hero_rectangle', successful[i].short_name + '.png')).convert('RGBA')
            draw_image(composition, hero_image, [hero_x- successful_x_padding, hero_y[0][i]], [None, hero_height])

        i = 0
        j = 0
        while i + 4*j < min(len(not_picked_heroes), 12):
            hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                 'hero_rectangle', not_picked_heroes[i + 4*j].short_name + '.png')).convert('RGBA')
            if i+4*j == 11:
                if len(not_picked_heroes) == 12:
                    draw_image(composition, hero_image, [75 + i*(hero_width + hero_y_padding), hero_y[0][5+j]], [None, hero_height])
                else:
                    draw_text_center_align(image_draw, [75 + i*(hero_width + hero_y_padding) + int(hero_width/2), hero_y[0][5+j]], text='+{0}'.format(len(not_picked_heroes)-11), font=rift_title, fill=self.colors['ti_green'])
            else:
                draw_image(composition, hero_image, [75 + i*(hero_width + hero_y_padding), hero_y[0][5+j]], [None, hero_height])
            i += 1
            if i == 4:
                i = 0
                j += 1

        image_draw = ImageDraw.Draw(composition)
        for i in range(0, len(picks)):
            image_draw.text([hero_x + hero_width + 20, hero_y[0][i]], '{0:.0f} ({1:.1f} %)'.format(picks_stat[i].nb_pick, picks_stat[i].mean_is_win*100), font=rift_text, fill=self.colors['white'])
        for i in range(0, len(bans)):
            ban_wr = '-'
            if bans_stat[i].mean_is_win is not None:
                ban_wr = '{0:.1f}'.format(bans_stat[i].mean_is_win*100)
            image_draw.text([hero_x + hero_width + 20, hero_y[1][i]], '{0:.0f} ({1} %)'.format(bans_stat[i].nb_ban, ban_wr), font=rift_text, fill=self.colors['white'])
        draw_text_center_align(image_draw, [hero_x + 250, hero_y[0][0] - 100], 'Most Picked', font=rift_subtitle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [hero_x + 250, hero_y[1][0] - 100], 'Most Banned', font=rift_subtitle, fill=self.colors['white'])

        draw_text_center_align(image_draw, [hero_x + 250 - successful_x_padding, hero_y[0][0] - 100], 'Best Picks', font=rift_subtitle, fill=self.colors['white'])
        for i in range(0, len(successful)):
            image_draw.text([hero_x + hero_width + 20 - successful_x_padding, hero_y[0][i]], '{0:.1f} % ({1:.0f})'.format(successful_stat[i].mean_is_win*100, successful_stat[i].nb_pick), font=rift_text, fill=self.colors['white'])

        draw_text_center_align(image_draw, [425, hero_y[0][0] - 100], text='WR Sides', font=rift_subtitle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [212, hero_y[0][0]], text='RADIANT', font=rift_subtitle, fill=self.colors['dota_green'])
        draw_text_center_align(image_draw, [212, hero_y[0][1]], text='{0:.1f} %'.format(radian_wr), font=rift_text, fill=self.colors['dota_green'])
        draw_text_center_align(image_draw, [637, hero_y[0][0]], text='DIRE', font=rift_subtitle, fill=self.colors['dota_red'])
        draw_text_center_align(image_draw, [637, hero_y[0][1]], text='{0:.1f} %'.format(dire_wr), font=rift_text, fill=self.colors['dota_red'])
        draw_text_center_align(image_draw, [212, hero_y[0][2]], text='Games', font=rift_subtitle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [212, hero_y[0][3]], text='{0}'.format(nb_games), font=rift_text, fill=self.colors['white'])
        draw_text_center_align(image_draw, [637, hero_y[0][2]], text='Duration', font=rift_subtitle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [637, hero_y[0][3]], text='{0:02}:{1:02}'.format(mean_duration_min, mean_duration_sec), font=rift_text, fill=self.colors['white'])
        draw_text_center_align(image_draw, [425, hero_y[1][0] - 100], 'Never Picked', font=rift_subtitle, fill=self.colors['white'])

        composition.save(generated_path)
