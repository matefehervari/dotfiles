import math

import cairo


def trace_rectangle(
    ctx: cairo.Context,
    x: int,
    y: int,
    width: int,
    height: int,
    border_radius: int,
):
    if border_radius > 0:
        corner_radius = border_radius

        radius = corner_radius
        degrees = math.pi / 180.0

        ctx.new_sub_path()
        ctx.arc(x + width - radius, y + radius, radius, -90 * degrees, 0 * degrees)
        ctx.arc(
            x + width - radius, y + height - radius, radius, 0 * degrees, 90 * degrees
        )
        ctx.arc(x + radius, y + height - radius, radius, 90 * degrees, 180 * degrees)
        ctx.arc(x + radius, y + radius, radius, 180 * degrees, 270 * degrees)
        ctx.close_path()

    else:
        ctx.rectangle(x, y, width, height)


def draw_rectangle(
    ctx: cairo.Context,
    x: int,
    y: int,
    width: int,
    height: int,
    border_radius: int,
    border_size: int,
    color: list[int],
    border_color: list[int],
    exclude_mask_dims: list[tuple[int, int, int, int]],  # x, y, width, height, radius
) -> None:
    ctx.set_source_rgba(color[0] / 255, color[1] / 255, color[2] / 255, color[3])
    trace_rectangle(ctx, x, y, width, height, border_radius)

    ctx.fill_preserve()
    if border_size != 0:
        ctx.set_source_rgba(
            border_color[0] / 255,
            border_color[1] / 255,
            border_color[2] / 255,
            border_color[3],
        )
        ctx.set_line_width(border_size)
        ctx.stroke()

    for dim in exclude_mask_dims:
        clear_region(ctx, *dim, border_radius)


def clear_region(ctx, x, y, width: int, height: int, radius: int):
    ctx.set_source_rgba(0, 0, 0, 0)
    ctx.set_operator(cairo.OPERATOR_CLEAR)
    trace_rectangle(ctx, x, y, width, height, radius)
    ctx.fill()
    ctx.set_operator(cairo.OPERATOR_OVER)
