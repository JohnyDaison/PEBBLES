if(visible)
{
    if(place_meeting(x,y, terrain_obj))
    {
        alarm[0] = gamemode_obj.regenerate_terrain_delay;
        visible = false;
        exit;
    }
    
    image_alpha = 1 - 0.5*(image_index/image_number);
    
    if((image_index + image_speed) <= 0)
    {
        var regen_ter = instance_create(x, y, wall_obj);
        regen_ter.energy = energy;
        regen_ter.my_next_color = my_color;
        regen_ter.damage = damage;
        regen_ter.color_locked = color_locked;
        
        var step = body_offset_step;
        var bodies = ds_list_create();
        var body_count, body, body_offset, body_offset_limit;
        
        with (regen_ter) {
            instance_place_list(x, y, phys_body_obj, bodies, false);
            body_count = ds_list_size(bodies);
            
            for(var index = 0; index < body_count; index++) {
                body = bodies[| index];
                body_offset = 0;
                body_offset_limit = 2 * (body.radius + regen_ter.radius);
                
                with (body) {
                    while (body_offset < body_offset_limit) {
                        if (!place_meeting(x + body_offset, y, supported_terrain)) {
                            x += body_offset;
                            break;
                        }
                        
                        if (!place_meeting(x - body_offset, y, supported_terrain)) {
                            x -= body_offset;
                            break;
                        }
                        
                        if (!place_meeting(x, y + body_offset, supported_terrain)) {
                            y += body_offset;
                            break;
                        }
                        
                        if (!place_meeting(x, y - body_offset, supported_terrain)) {
                            y -= body_offset;
                            break;
                        }
                        
                        body_offset += step;
                    }
                }
            }
        }
        
        ds_list_destroy(bodies);
        instance_destroy();
    }
}