import os
import types
import math
from PIL import Image, ImageDraw, ImageFont
from tornado_sqlalchemy import as_future
from tornado.gen import multi
from sqlalchemy import desc

from models import DotaJoinGlobalHeroes, DotaJoinGlobal
from image_generation.helpers import draw_text_outlined_center_align, draw_image, draw_text_center_align


class TournamentGlobalsMixin:

    async def generate_tournament_globals(self):

        # Delete old file if exists
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
        draw_text_outlined_center_align(
            draw=image_draw, position=[960, 35], text='The International IX',
            font=rift_title, fill=self.colors['ti_purple'], outline_fill=self.colors['black'], outline_width=4)

        # Database requests
        hero_top_wr, hero_top_pick, hero_top_ban, hero_no_pick, stat_tn = await multi([
            as_future(self.session.query(DotaJoinGlobalHeroes)
                      .filter(DotaJoinGlobalHeroes.nb_pick != 0, DotaJoinGlobalHeroes.nb_pick >= 5)
                      .order_by(desc(DotaJoinGlobalHeroes.mean_is_win), DotaJoinGlobalHeroes.display_name)
                      .limit(8).all),
            as_future(self.session.query(DotaJoinGlobalHeroes)
                      .order_by(desc(DotaJoinGlobalHeroes.nb_pick)).limit(4).all),
            as_future(self.session.query(DotaJoinGlobalHeroes)
                      .order_by(desc(DotaJoinGlobalHeroes.nb_ban)).limit(3).all),
            as_future(self.session.query(DotaJoinGlobalHeroes)
                      .filter(DotaJoinGlobalHeroes.nb_pick == 0).all),
            as_future(self.session.query(DotaJoinGlobal)
                      .one_or_none)
        ])

        # Side WR
        radian_wr = 0
        dire_wr = 0
        nb_games = 0
        mean_duration_min = 0
        mean_duration_sec = 0
        if stat_tn is not None:
            nb_games = int(stat_tn.nb_match)
            radian_wr = stat_tn.mean_radiant_win*100
            dire_wr = 100 - radian_wr
            mean_duration_sec = math.ceil(stat_tn.mean_duration) % 60
            mean_duration_min = int(math.ceil(stat_tn.mean_duration - mean_duration_sec) / 60)

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
        for i in range(0, len(hero_top_pick)):
            hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                 'hero_rectangle', hero_top_pick[i].short_name + '.png')).convert('RGBA')
            draw_image(composition, hero_image, [hero_x, hero_y[0][i]], [None, hero_height])
        for i in range(0, len(hero_top_ban)):
            hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                 'hero_rectangle', hero_top_ban[i].short_name + '.png')).convert('RGBA')
            draw_image(composition, hero_image, [hero_x, hero_y[1][i]], [None, hero_height])
        for i in range(0, len(hero_top_wr)):
            hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                 'hero_rectangle', hero_top_wr[i].short_name + '.png')).convert('RGBA')
            draw_image(composition, hero_image, [hero_x- successful_x_padding, hero_y[0][i]], [None, hero_height])

        i = 0
        j = 0
        while i + 4*j < min(len(hero_no_pick), 12):
            hero_image = Image.open(os.path.join(self.assets_root, 'dota',
                                                 'hero_rectangle', hero_no_pick[i + 4*j].short_name + '.png')).convert('RGBA')
            if i+4*j == 11:
                if len(hero_no_pick) == 12:
                    draw_image(composition, hero_image, [75 + i*(hero_width + hero_y_padding), hero_y[0][5+j]], [None, hero_height])
                else:
                    draw_text_center_align(image_draw, [75 + i*(hero_width + hero_y_padding) + int(hero_width/2), hero_y[0][5+j]], text='+{0}'.format(len(hero_no_pick)-11), font=rift_title, fill=self.colors['ti_purple'])
            else:
                draw_image(composition, hero_image, [75 + i*(hero_width + hero_y_padding), hero_y[0][5+j]], [None, hero_height])
            i += 1
            if i == 4:
                i = 0
                j += 1

        image_draw = ImageDraw.Draw(composition)
        for i in range(0, len(hero_top_pick)):
            image_draw.text([hero_x + hero_width + 20, hero_y[0][i]], '{0:.0f} ({1:.1f} %)'.format(hero_top_pick[i].nb_pick, hero_top_pick[i].mean_is_win*100), font=rift_text, fill=self.colors['white'])
        for i in range(0, len(hero_top_ban)):
            ban_wr = '-'
            if hero_top_ban[i].mean_is_win is not None:
                ban_wr = '{0:.1f}'.format(hero_top_ban[i].mean_is_win*100)
            image_draw.text([hero_x + hero_width + 20, hero_y[1][i]], '{0:.0f} ({1} %)'.format(hero_top_ban[i].nb_ban, ban_wr), font=rift_text, fill=self.colors['white'])
        draw_text_center_align(image_draw, [hero_x + 250, hero_y[0][0] - 100], 'Most Picked', font=rift_subtitle, fill=self.colors['white'])
        draw_text_center_align(image_draw, [hero_x + 250, hero_y[1][0] - 100], 'Most Banned', font=rift_subtitle, fill=self.colors['white'])

        draw_text_center_align(image_draw, [hero_x + 250 - successful_x_padding, hero_y[0][0] - 100], 'Best Picks', font=rift_subtitle, fill=self.colors['white'])
        for i in range(0, len(hero_top_wr)):
            image_draw.text([hero_x + hero_width + 20 - successful_x_padding, hero_y[0][i]], '{0:.1f} % ({1:.0f})'.format(hero_top_wr[i].mean_is_win*100, hero_top_wr[i].nb_pick), font=rift_text, fill=self.colors['white'])

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
