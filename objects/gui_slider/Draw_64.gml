event_inherited();

draw_set_color(bar_color);
draw_set_alpha(1);

var bar_ratio = (value - bar_min_value) / (bar_max_value - bar_min_value);

if(round_corners)
{
    draw_roundrect_ext(x + 1, y + 1,
                       x + width * bar_ratio - 1, y + height - 1,
                       corner_radius, corner_radius, false);
}
else
{
    draw_rectangle(x + 1, y + 1, x + width * bar_ratio - 1, y + height - 1, false);
}