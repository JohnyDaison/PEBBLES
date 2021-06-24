if (instance_exists(guy_obj) && alarm[4] == -1 && !lightup_sequence_started) {
    alarm[4] = lightup_sequence_wait_time * singleton_obj.game_speed;
}

var controller = self;

if (lightup_sequence_started && !lightup_sequence_finished) {
    if (goto_next) {
        lightup_sequence_index++;
        var zone_id = lightup_sequence[| lightup_sequence_index];
        
        if (is_undefined(zone_id)) {
            lightup_sequence_finished = true;
        } else {
            var zone = group_find_member(get_group("zones"), zone_id);
            
            with(zone) {
                var colorizer = instance_create(x,y, colorizer_obj);
                
                colorizer.my_color = my_color;
                colorizer.sprite_index = sprite_index;
                colorizer.image_xscale = image_xscale;
                colorizer.image_yscale = image_yscale;
                
                var invisibilizer = instance_create(x,y, invisibilizer_obj);
                
                invisibilizer.invisible = false;
                invisibilizer.sprite_index = sprite_index;
                invisibilizer.image_xscale = image_xscale;
                invisibilizer.image_yscale = image_yscale;
                
                var torch = instance_place(x,y, crystal_ball_torch_obj);
                
                if (torch != noone) {
                    controller.torch_obj = torch;
                }
            }
        }
        
        goto_next = false;
    }
    
    torch_obj.energy += torch_energy_tick;
    
    if (torch_obj.energy >= torch_obj.max_energy) {
        goto_next = true;
    }
}
