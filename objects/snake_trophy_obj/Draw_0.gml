draw_sprite_ext(sprite_index, image_index, x,y, 1,1,0, tint, 1);

if(DB.console_mode == CONSOLE_MODE.TEST || DB.console_mode == CONSOLE_MODE.DEBUG)
{
    if(instance_exists(my_block))
    {
        draw_set_color(c_yellow);
        draw_set_alpha(1);
        draw_line_width(x,y, my_block.x, my_block.y, 3);   
    }
    else
    {
        tint = c_red;   
    }
}

event_inherited();
