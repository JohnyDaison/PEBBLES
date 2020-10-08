/// @description  UPDATE BAR COLOR
if(!tint_updated)
{
    base_bar_color = DB.colormap[? my_color];
    feed_bar_color = merge_colour(base_bar_color, c_white, 0.66);
}

event_inherited();
