event_inherited();

minimap_left = x + map_margin;
minimap_top = y + map_margin;
minimap_right = x + width - map_margin - 1;
minimap_bottom = y + height - map_margin - 1;

minimap_width = minimap_right - minimap_left;
minimap_height = minimap_bottom - minimap_top;

minimap_view_width = floor(__view_get( e__VW.WView, 0 )/32)*mini_block_size;
minimap_view_height = floor(__view_get( e__VW.HView, 0 )/32)*mini_block_size;

minimap_view_left = minimap_left + floor(minimap_width/2 - minimap_view_width/2);
minimap_view_top = minimap_top + floor(minimap_height/2 - minimap_view_height/2);
minimap_view_right = minimap_view_left + minimap_view_width;
minimap_view_bottom = minimap_view_top + minimap_view_height;

draw_set_alpha(0.9);
draw_set_color(c_ltgray);
draw_rectangle(minimap_left-1,minimap_top-1,minimap_right+1,minimap_bottom+1,true);
draw_set_color(__background_get_colour( ));
draw_rectangle(minimap_left,minimap_top,minimap_right,minimap_bottom,false);

with(editor_terrain_obj)
{
    draw_set_color(final_tint);
    /*
    switch(palette_index)
    {
        case 1:
            draw_set_color(final_tint);
        break;
        case 2:
            
        break;
    }*/
    
    minimap_x = other.minimap_view_left + floor(x/32 * other.mini_block_size) - floor(__view_get( e__VW.XView, 0 )/32)*other.mini_block_size;
    minimap_y = other.minimap_view_top + floor(y/32 * other.mini_block_size) - floor(__view_get( e__VW.YView, 0 )/32)*other.mini_block_size;
    
    if(minimap_x >= other.minimap_left && minimap_x <= other.minimap_right - (other.mini_block_size-1)
    && minimap_y >= other.minimap_top && minimap_y <= other.minimap_bottom - (other.mini_block_size-1))
    {
        draw_rectangle(minimap_x,minimap_y,minimap_x+1,minimap_y+1,false);
    }
}

draw_set_alpha(0.6);
draw_set_color(c_yellow);

draw_rectangle(minimap_view_left,minimap_view_top,minimap_view_right,minimap_view_bottom,true);
