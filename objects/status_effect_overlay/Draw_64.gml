if(ready && instance_exists(my_guy))
{ 
    if(!my_guy.dead)
    {
        var active_count = ds_list_size(status_order);
                
        offset_x = x - status_distance/2;
        offset_y = y + ceil(status_height/2);
        
        if(last_width > 0)
        {
            draw_set_colour(c_white);
            draw_set_alpha(0.9);
            draw_rectangle(x-last_width, y, x, y+status_height, false);
            draw_set_alpha(0.5);
            draw_line(x-last_width, y, x-last_width, y+status_height);
        }
        
        for(var i = 0; i < active_count; i++)
        { 
            var effect_id = status_order[| i];
            var effect = DB.status_effects[? effect_id];

            var effect_tint = DB.colormap[? effect.color];
            var effect_alpha = status_alpha[? effect_id];

            if(effect_alpha > 0)
            {            
                if(effect.buff != 0)
                {
                    draw_sprite_ext(status_background_spr, effect.buff+1, offset_x, offset_y, 1, 1, 0, c_white, effect_alpha);
                }
                
                draw_sprite_ext(status_background_spr, 1, offset_x, offset_y, 1, 1, 0, effect_tint, effect_alpha);
                
                draw_sprite_ext(effect.icon, 0, offset_x, offset_y, 1, 1, 0, c_white, effect_alpha);
                
                if(effect_alpha >= 0.5)
                {
                    offset_x -= status_distance;
                }
                else
                {
                    offset_x -= status_distance * 2*effect_alpha;
                }
            }
        }
        if(active_count == 0)
        {
            if(last_width != 0)
            {
                if(last_width > 0)
                {
                    last_width -= status_fade_rate*status_distance;
                }
                
                if(last_width < 0)
                {
                    last_width = 0;
                }
            }
        }
        else
        {
            last_width = x - (offset_x + status_distance/2);
        }
    }
}
