event_inherited();

draw_set_color(bar_color);
draw_set_alpha(1);

var bar_ratio = (value - bar_min_value) / (bar_max_value - bar_min_value);

if(round_corners)
{
    draw_roundrect(x + 1, y + 1, x + width * bar_ratio, y + height, false);
}
else
{
    draw_rectangle(x + 1, y + 1, x + width * bar_ratio, y + height, false);
}