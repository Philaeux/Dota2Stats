from PIL import Image, ImageDraw


def draw_image(composition, image, position, size):
    new_width = int(image.size[0] * size[1] / image.size[1])
    new_height = size[1]

    resized_image = image.resize([new_width, new_height], Image.LANCZOS)
    composition.paste(resized_image, box=position)


def draw_text_left_align(draw, position, text, font, fill):
    w, h = draw.textsize(text=text, font=font)
    draw.text([position[0] - w, position[1]], text, font=font, fill=fill)


def draw_text_center_align(draw, position, text, font, fill):
    w, h = draw.textsize(text=text, font=font)
    new_x = position[0] - int(w / 2)
    draw.text([new_x, position[1]], text, font=font, fill=fill)


def draw_text_outlined(draw, position, text, font, fill, outline_fill, outline_width):
    draw.text((position[0] - outline_width, position[1] - outline_width), text, font=font, fill=outline_fill)
    draw.text((position[0] + outline_width, position[1] - outline_width), text, font=font, fill=outline_fill)
    draw.text((position[0] - outline_width, position[1] + outline_width), text, font=font, fill=outline_fill)
    draw.text((position[0] + outline_width, position[1] + outline_width), text, font=font, fill=outline_fill)

    draw.text(position, text, font=font, fill=fill)


def draw_text_outlined_center_align(draw, position, text, font, fill, outline_fill, outline_width):
    w, h = draw.textsize(text=text, font=font)
    new_x = position[0] - int(w/2)

    draw.text((new_x - outline_width, position[1] - outline_width), text, font=font, fill=outline_fill)
    draw.text((new_x + outline_width, position[1] - outline_width), text, font=font, fill=outline_fill)
    draw.text((new_x - outline_width, position[1] + outline_width), text, font=font, fill=outline_fill)
    draw.text((new_x + outline_width, position[1] + outline_width), text, font=font, fill=outline_fill)

    draw.text([new_x, position[1]], text, font=font, fill=fill)


def draw_alpha_rectangle(composition, positions, fill, alpha):
    in_place_rectangle = Image.new('RGBA', (composition.size[0], composition.size[1]))
    image_draw = ImageDraw.Draw(in_place_rectangle)
    image_draw.rectangle(xy=positions, fill=fill)
    in_place_rectangle = Image.blend(Image.new('RGBA', (composition.size[0], composition.size[1])),
                                     in_place_rectangle, alpha)
    return Image.alpha_composite(composition, in_place_rectangle)


def draw_image_advanced(composition, image, position, size, alpha):
    new_width = int(image.size[0] * size[1] / image.size[1])
    new_height = size[1]

    team_logo = image.resize([new_width, new_height], Image.LANCZOS)
    in_place_logo = Image.new('RGBA', (composition.size[0], composition.size[1]))
    in_place_logo.paste(team_logo,
                        box=[position[0] - int(team_logo.size[0] / 2),
                             position[1] - int(team_logo.size[1] / 2)],
                        mask=team_logo)
    in_place_logo = Image.blend(Image.new('RGBA', (composition.size[0], composition.size[1])), in_place_logo, alpha)
    return Image.alpha_composite(composition, in_place_logo)
