if(instance_exists(my_guy) && sprite_index != noone && my_color != g_dark)
{   
    blink_off = false;
    
    if(object_is_ancestor(my_guy.object_index, guy_obj) && my_guy.blink_off)
    {
        blink_off = true;    
    }
    
    if(!blink_off)
    {    
        draw_sprite_ext(sprite_index,image_index, x,y, image_xscale,image_yscale,
                        0, self.tint, glitch_alpha*alpha*image_alpha*self.holo_alpha);
        if(impact_draw)
        {
            for(i = impact_anim_length-1;i>=0;i-=1)
            {
                var tint = ds_map_find_value(impact_tints, i);
                var dir = ds_map_find_value(impact_directions, i);
                if(tint != -1 && dir != -1) {
                    var impact_alpha = 1 - i/12;
                    
                    draw_sprite_ext(impact_sprite,i, x,y, image_xscale,image_yscale,
                                    dir, tint, impact_alpha*image_alpha*self.holo_alpha);
                }
            }
        }
        
        if(my_guy != id)
        {
            draw_sprite_ext(shield_texture_spr,0, x,y, image_xscale,image_yscale,
                        0, c_white, glitch_alpha*self.holo_alpha);    //self.tint
        }
    
        if(size > 1)
        {
            part_system_drawit(system);
        }
    }
}
else 
{
    show_debug_message("cannot draw shield");
    if(my_guy != noone)
    {
        instance_destroy();
    }
}

event_inherited();

// debug
/*
draw_set_color(c_white);
draw_text(x,y, string(collapse_threshold) + " " + string(charge) + " " + string(max_charge) + " " + string(threshold));
*/
