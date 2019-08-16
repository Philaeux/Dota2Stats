import os
import types
import math
from PIL import Image, ImageDraw, ImageFont
from tornado_sqlalchemy import as_future
from tornado.gen import multi
from sqlalchemy import desc

from models import DotaJoinGlobalHeroes, DotaJoinGlobal
from image_generation.helpers import draw_text_outlined_center_align, draw_image, draw_text_center_align


class TournamentFunMixin:

    async def generate_tournament_fun(self):

        # Delete old file if exists
        generated_path = os.path.join(self.generated_root, "tournament_fun.png")
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
            draw=image_draw, position=[960, 35], text='Pepeg-   SHOW',
            font=rift_title, fill=self.colors['ti_purple'], outline_fill=self.colors['black'], outline_width=4)

        # Database requests

        composition.save(generated_path)
