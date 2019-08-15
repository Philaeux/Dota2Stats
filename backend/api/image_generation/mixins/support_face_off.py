import os
import time
from PIL import Image, ImageDraw, ImageFont
from tornado_sqlalchemy import as_future
from tornado.gen import multi

from image_generation.helpers import draw_text_center_align
from models import DotaJoinGlobalTeam, DotaProPlayer


class SupportFaceOffMixin:

    async def generate_support_face_off(self, team_1, team_2):
        # Delete previous image
        generated_path = os.path.join(
            self.generated_root, "support_face_off-" + str(team_1) + "-" + str(team_2) + ".png")
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

        team_stats = await multi([
            as_future(self.session.query(DotaJoinGlobalTeam).filter(DotaJoinGlobalTeam.team_id == team_1).one_or_none),
            as_future(self.session.query(DotaJoinGlobalTeam).filter(DotaJoinGlobalTeam.team_id == team_2).one_or_none)
        ])
        players = await multi([
            as_future(self.session.query(DotaProPlayer).filter(DotaProPlayer.team_id == team_1, DotaProPlayer.position >= 4).all),
            as_future(self.session.query(DotaProPlayer).filter(DotaProPlayer.team_id == team_2, DotaProPlayer.position >= 4).all)
        ])

        draw_text_center_align(image_draw, [480, 30], '{0}'.format(team_stats[0].team_name), font=rift_title,
                               fill=self.colors['ti_purple'])
        draw_text_center_align(image_draw, [1440, 30], '{0}'.format(team_stats[1].team_name), font=rift_title,
                               fill=self.colors['ti_purple'])

        image_draw.text([100, 100], str(time.time()), font=rift_title, fill=self.colors['light_red'])
        image_draw.text([100, 200], "Support Face off bouffon", font=rift_title, fill=self.colors['light_red'])

        composition.save(generated_path)
