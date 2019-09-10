import os
from PIL import Image, ImageDraw, ImageFont
from tornado_sqlalchemy import as_future
from sqlalchemy import desc
from tornado.gen import multi

from image_generation.helpers import draw_image_advanced, draw_text_center_align, draw_alpha_rectangle, \
    draw_text_right_align, draw_text_outlined, draw_text_outlined_right_align
from models import DotaJoinGlobalPlayer, DotaProTeam, DotaJoinGlobalPlayerHero


class SupportFaceOffMixin:

    async def generate_support_face_off(self, team_1, team_2):

        # Delete previous image
        generated_path = os.path.join(self.generated_root, "support_face_off-" + str(team_1) + "-" + str(team_2) + ".png")
        if os.path.exists(generated_path):
            os.remove(generated_path)

        # Fonts
        rift_title = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 72)
        rift_player_nickname = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold_italic.otf'), 46)
        noto_cjk_player_nickname = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'noto', 'noto_sans_cjk_bold.otf'), 38)
        hero_count = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 36)
        rift_stat = ImageFont.truetype(
            os.path.join(self.assets_root, 'fonts', 'rift', 'fort_foundry_rift_bold.otf'), 56)

        composition = Image.open(os.path.join(self.assets_root, 'background3.png')).convert('RGBA')
        image_draw = ImageDraw.Draw(composition)

        # Database access
        teams = await multi([
            as_future(self.session.query(DotaProTeam).filter(DotaProTeam.id == team_1).one_or_none),
            as_future(self.session.query(DotaProTeam).filter(DotaProTeam.id == team_2).one_or_none)
        ])
        all_players = await multi([
            as_future(self.session.query(DotaJoinGlobalPlayer)
                      .filter(DotaJoinGlobalPlayer.team_id == team_1)
                      .order_by(DotaJoinGlobalPlayer.position)
                      .limit(5).all),
            as_future(self.session.query(DotaJoinGlobalPlayer)
                      .filter(DotaJoinGlobalPlayer.team_id == team_2)
                      .order_by(DotaJoinGlobalPlayer.position)
                      .limit(5).all)
        ])
        players = [all_players[0][3:5], all_players[1][3:5]]
        total_gold = [0, 0]

        draw_text_center_align(image_draw, [480, 30], '{0}'.format(teams[0].name), font=rift_title,
                               fill=self.colors['ti_purple'])
        draw_text_center_align(image_draw, [1440, 30], '{0}'.format(teams[1].name), font=rift_title,
                               fill=self.colors['ti_purple'])

        # Drawing tweaks
        center_line_padding = 15
        player_face_height = 200
        border_width = 5
        hero_height = int((player_face_height + 2 * border_width) / 3)
        hero_width = int(256 * hero_height / 144)
        row_start = [235+140, 470+235+140]
        image_center_x = 960
        player_face_center_x = 800
        nickname_padding = 35
        icon_size = 80
        nb_pick_padding_x = 7
        nb_pick_padding_y = -15

        # Draw lines
        image_draw.line(xy=[960, row_start[0] + 2*icon_size + center_line_padding,
                            960, row_start[1] - 2*icon_size - center_line_padding],
                        width=5, fill=self.colors["white"])

        # Player
        skull_image = Image.open(os.path.join(self.assets_root, 'icons', 'skull.png')).convert('RGBA')
        gold_icon = Image.open(os.path.join(self.assets_root, 'icons', 'gold.png')).convert('RGBA')
        vision_icon = Image.open(os.path.join(self.assets_root, 'icons', 'vision.png')).convert('RGBA')
        roaming_icon = Image.open(os.path.join(self.assets_root, 'icons', 'roaming.png')).convert('RGBA')
        fight_icon = Image.open(os.path.join(self.assets_root, 'icons', 'fight.png')).convert('RGBA')
        stun_icon = Image.open(os.path.join(self.assets_root, 'icons', 'stun.png')).convert('RGBA')
        stack_icon = Image.open(os.path.join(self.assets_root, 'icons', 'stack.png')).convert('RGBA')
        bounty_icon = Image.open(os.path.join(self.assets_root, 'icons', 'bounty.png')).convert('RGBA')

        for i in range(0, 2):
            for j, player in enumerate(all_players[i]):
                total_gold[i] += player.mean_gold + player.mean_gold_spent
            for j in range(0, len(players[i])):
                player = players[i][j]

                player_heroes = await  as_future(
                    self.session.query(DotaJoinGlobalPlayerHero)
                        .filter(DotaJoinGlobalPlayerHero.account_id == player.account_id)
                        .order_by(desc(DotaJoinGlobalPlayerHero.nb_pick))
                        .limit(3).all)

                # Heroes
                for index, hero in enumerate(player_heroes):
                    hero_path = os.path.join(self.assets_root, "dota", "hero_rectangle", hero.short_name + ".png")
                    if os.path.exists(hero_path):
                        hero_image = Image.open(hero_path).convert('RGBA')
                        composition = draw_image_advanced(composition, hero_image,
                                                          [image_center_x + pow(-1, i+1)*(player_face_center_x - player_face_height + int(hero_height/2) - int(border_width/2)),
                                                           row_start[j] + index*hero_height - int(player_face_height/2) + int(hero_height/2) - border_width],
                                                          [None, hero_height],
                                                          1)
                image_draw = ImageDraw.Draw(composition)
                for index, hero in enumerate(player_heroes):
                    position = [image_center_x + pow(-1, i+1) * (player_face_center_x - int(player_face_height/2) - border_width - hero_width) + nb_pick_padding_x - (1-i)*hero_width,
                                row_start[j] + index * hero_height - int(player_face_height / 2) + int(hero_height / 2) + nb_pick_padding_y]
                    draw_text_outlined(image_draw,
                                       position=position,
                                       text="{:.0f}".format(hero.nb_pick),
                                       font=hero_count,
                                       fill=self.colors['white'],
                                       outline_fill=self.colors['black'],
                                       outline_width=3)
                    draw_text_outlined_right_align(image_draw,
                                                   position=[position[0] + hero_width - 2 * nb_pick_padding_x,
                                                             position[1]],
                                                   text="{:.0f}".format(hero.nb_win),
                                                   font=hero_count,
                                                   fill=self.colors['ti_green'],
                                                   outline_fill=self.colors['black'],
                                                   outline_width=3)

                # Stats
                icon_padding_x = 500
                if i == 0:
                    composition = draw_image_advanced(composition, skull_image,
                                                      [image_center_x, row_start[j] - 3*int(icon_size/2)],
                                                      [None, icon_size],
                                                      1)
                    composition = draw_image_advanced(composition, gold_icon,
                                                      [image_center_x, row_start[j] - int(icon_size/2)],
                                                      [None, icon_size],
                                                      1)
                    composition = draw_image_advanced(composition, fight_icon,
                                                      [image_center_x, row_start[j]+int(icon_size/2)],
                                                      [None, icon_size],
                                                      1)
                    composition = draw_image_advanced(composition, vision_icon,
                                                      [image_center_x, row_start[j]+3*int(icon_size/2)],
                                                      [None, icon_size],
                                                      1)

                composition = draw_image_advanced(composition, stun_icon,
                                                  [image_center_x + pow(-1, i+1) * icon_padding_x,
                                                   row_start[j] - 3*int(icon_size/2)],
                                                  [None, icon_size],
                                                  1)
                composition = draw_image_advanced(composition, bounty_icon,
                                                  [image_center_x + pow(-1, i+1) * icon_padding_x,
                                                   row_start[j] - int(icon_size/2)],
                                                  [None, icon_size],
                                                  1)
                composition = draw_image_advanced(composition, stack_icon,
                                                  [image_center_x + pow(-1, i+1) * icon_padding_x,
                                                   row_start[j] + int(icon_size/2)],
                                                  [None, icon_size],
                                                  1)
                composition = draw_image_advanced(composition, roaming_icon,
                                                  [image_center_x + pow(-1, i+1) * icon_padding_x,
                                                   row_start[j] + 3*int(icon_size/2)],
                                                  [None, icon_size],
                                                  1)
                stat_padding_y = -35
                image_draw = ImageDraw.Draw(composition)
                position = [image_center_x + pow(-1, i+1) * icon_size, row_start[j]]
                mean_kda, mean_gold, mean_fight, mean_purchased_obs, mean_purchased_sen, mean_stun, \
                mean_bounty_pickups, mean_camps_stacked, mean_is_roaming = \
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
                if player.mean_kda is not None: mean_kda = player.mean_kda
                if player.mean_gold is not None and player.mean_gold_spent is not None:
                    mean_gold = (player.mean_gold + player.mean_gold_spent)*100/total_gold[i]
                if player.mean_teamfight_part is not None: mean_fight = player.mean_teamfight_part*100
                if player.mean_purchased_obs is not None: mean_purchased_obs = player.mean_purchased_obs
                if player.mean_purchased_sen is not None: mean_purchased_sen = player.mean_purchased_sen
                if player.mean_stun is not None: mean_stun = player.mean_stun
                if player.mean_bounty_pickups is not None: mean_bounty_pickups = player.mean_bounty_pickups
                if player.mean_camps_stacked is not None: mean_camps_stacked = player.mean_camps_stacked
                if player.mean_is_roaming is not None: mean_is_roaming = player.mean_is_roaming
                mean_kda_str = "{:.2f}".format(mean_kda)
                mean_gold_str = "{:.1f} %".format(mean_gold)
                mean_fight_str = "{:.1f} %".format(mean_fight)
                mean_wards_str = "{:.1f}/{:.1f}".format(mean_purchased_obs, mean_purchased_sen)
                mean_stun_str = '{:.1f} "'.format(mean_stun)
                mean_bounty_pickups_str = "{:.1f}".format(mean_bounty_pickups)
                mean_camps_stacked_str = "{:.1f}".format(mean_camps_stacked)
                mean_is_roaming_str = "{:.1f} %".format(mean_is_roaming*100)

                if i == 1:
                    image_draw.text([position[0], position[1] + stat_padding_y - 3*int(icon_size/2)], mean_kda_str, font=rift_stat, fill=self.colors["white"])
                    image_draw.text([position[0], position[1] + stat_padding_y - int(icon_size/2)], mean_gold_str, font=rift_stat, fill=self.colors["white"])
                    image_draw.text([position[0], position[1] + stat_padding_y + int(icon_size/2)], mean_fight_str, font=rift_stat, fill=self.colors["white"])
                    image_draw.text([position[0], position[1] + stat_padding_y + 3*int(icon_size/2)], mean_wards_str, font=rift_stat, fill=self.colors["white"])
                    draw_text_right_align(image_draw, [position[0]+icon_padding_x - 2*icon_size, position[1] + stat_padding_y - 3*int(icon_size/2)], mean_stun_str, font=rift_stat, fill=self.colors["white"])
                    draw_text_right_align(image_draw, [position[0]+icon_padding_x - 2*icon_size, position[1] + stat_padding_y - int(icon_size/2)], mean_bounty_pickups_str, font=rift_stat, fill=self.colors["white"])
                    draw_text_right_align(image_draw, [position[0]+icon_padding_x - 2*icon_size, position[1] + stat_padding_y + int(icon_size/2)], mean_camps_stacked_str, font=rift_stat, fill=self.colors["white"])
                    draw_text_right_align(image_draw, [position[0]+icon_padding_x - 2*icon_size, position[1] + stat_padding_y + 3*int(icon_size/2)], mean_is_roaming_str, font=rift_stat, fill=self.colors["white"])
                else:
                    draw_text_right_align(image_draw, [position[0], position[1] + stat_padding_y - 3*int(icon_size/2)], mean_kda_str, font=rift_stat, fill=self.colors["white"])
                    draw_text_right_align(image_draw, [position[0], position[1] + stat_padding_y - int(icon_size/2)], mean_gold_str, font=rift_stat, fill=self.colors["white"])
                    draw_text_right_align(image_draw, [position[0], position[1] + stat_padding_y + int(icon_size/2)], mean_fight_str, font=rift_stat, fill=self.colors["white"])
                    draw_text_right_align(image_draw, [position[0], position[1] + stat_padding_y + 3*int(icon_size/2)], mean_wards_str, font=rift_stat, fill=self.colors["white"])
                    image_draw.text([position[0]-icon_padding_x + 2*icon_size, position[1] + stat_padding_y - 3*int(icon_size/2)], mean_stun_str, font=rift_stat, fill=self.colors["white"])
                    image_draw.text([position[0]-icon_padding_x + 2*icon_size, position[1] + stat_padding_y - int(icon_size/2)], mean_bounty_pickups_str, font=rift_stat, fill=self.colors["white"])
                    image_draw.text([position[0]-icon_padding_x + 2*icon_size, position[1] + stat_padding_y + int(icon_size/2)], mean_camps_stacked_str, font=rift_stat, fill=self.colors["white"])
                    image_draw.text([position[0]-icon_padding_x + 2*icon_size, position[1] + stat_padding_y + 3*int(icon_size/2)], mean_is_roaming_str, font=rift_stat, fill=self.colors["white"])

                # Names
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

                # Face
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
