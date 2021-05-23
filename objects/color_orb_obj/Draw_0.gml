if(instance_exists(my_guy))
{
    if(sprite_index != noone)
    {
        draw_sprite_ext(sprite_index, image_index,
                        x, cur_y, size, size,
                        0, self.tint, fade_counter*image_alpha*0.5*holo_alpha);
        
        if(my_color > g_dark)
        {
            core_tint = c_white;
            
            if(draw_lightning)
            {
                if(lightning_color > 0)
                {
                    core_tint = DB.colormap[? lightning_color];
                }
                        
                lightning_tint = core_tint;
                
                draw_sprite_ext(tiny_glowcore_spr, image_index,
                        x, cur_y, size, size,
                        0, core_tint, fade_counter*image_alpha*0.5);
                            
                draw_set_color(lightning_tint);
                draw_set_alpha(lightning_alpha*holo_alpha);

                draw_lightning_width(x, cur_y, lightning_x, lightning_y,
                    lightning_width, lightning_steps, lightning_thickness);
            }
            
            if(instance_exists(drained_object))
            {
                draw_set_color(tint);
                draw_set_alpha(lightning_alpha*holo_alpha);
                
                var x_center = drained_object.x;
                var y_center = drained_object.y;
                
                if(drained_object.object_index == wall_obj)
                {
                    x_center += 15;
                    y_center += 15;
                }
                
                draw_lightning_width(x, cur_y, x_center, y_center,
                    lightning_width, lightning_steps, lightning_thickness);
            }
        }
        
        part_system_drawit(part_system);
    }
}
/*
my_draw_set_font(label_font);
my_draw_text(x+16, y+16, "[" + string(chunkgrid_x) + "," + string(chunkgrid_y) + "]");
*/

event_inherited();
