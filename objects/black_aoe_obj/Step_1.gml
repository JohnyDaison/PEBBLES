event_inherited();

with (guy_obj) {
    if (self.holographic == other.holographic) {
        var dist = point_distance(x, y, other.x, other.y);
        if (self.old_coef == 0) {
            self.old_coef = self.gravity_coef;
        }

        var ubershielded = is_shielded(id, "uber");

        if (dist < other.radius) {
            if (ubershielded) {
                self.my_shield.charge -= 0.01;
                my_sound_play(wall_hum_sound, true);
                //my_sound_play_colored(wall_hum_sound, my_shield.my_color, true);
            }

            if (self.id != other.my_guy && other.force > 0 && !ubershielded && !self.protected) {
                // SLOT THEFT
                /*
                other.slot = ds_list_find_value(self.color_slots,0);
                
                if(current_slot > 0 && !lost_control && !slots_triggered && instance_exists(other.slot))
                {   
                    if(other.slot.color_added || other.slot.color_held)
                    {
                        black_aoe_id = other.id;
                        
                        with(other.slot)
                        {
                            color_consumed = false;
                            color_held = true;
                            old_guy = my_guy.id;
                            my_guy = other.black_aoe_id;
                        }
                        
                        ds_list_delete(color_slots,0);
                            
                        self.slots_triggered = false;
                        self.current_slot = 0;
                        self.potential_abi_name = "";
                        self.slot_number -= 1;
                        
                        for(i = 0; i < self.slot_number; i += 1)
                        {
                            slot = ds_list_find_value(self.color_slots,i);
                            slot.color_added = false;
                            slot.color_held = false;
                            slot.color_consumed = false;
                            slot.sprite_index = no_sprite;
                        }
                        
                        alarm[3] = 1;
                        show_debug_message("Loser!");
                        
                        ds_list_add(other.stolen_slots,other.slot.id);
                        other.slot_count = ds_list_size(other.stolen_slots);
                    }
                }
                */

                // THROWING AROUND
                if (!self.protected && !self.stuck && !self.hit_handled) // && speed < max_speed
                {
                    self.gravity_direction = point_direction(self.x, self.y, other.x, other.y);
                    /*
                    if(dist < other.radius/6)
                    {
                        dist = other.radius/6;
                    }
                    */
                    self.gravity_coef = abs((1 - dist / other.radius)) * 2 * other.force;
                    if (self.vspeed == 0)
                        self.vspeed = sign(other.y - self.y);

                    if (!self.lost_control) {
                        if (sign(lengthdir_x(dist, self.gravity_direction)) == self.facing) {
                            self.back_hit = true;
                        }
                        else {
                            self.front_hit = true;
                        }
                    }
                    if (self.airborne) {
                        self.lost_control = true;
                    }

                    last_attacker_update(other.id, "body", "dark");
                }


            }
            else {
                /*
                // STOLEN SLOT RETRIEVAL
                if(other.stolen_slot != noone)
                {
                    if(slot_number < slot_maxnumber)
                    {
                        ds_list_insert(color_slots,0,other.stolen_slot.id);
                        slot_number += 1;
                        other.stolen_slot.my_guy = self.id;
                        current_slot += 1;
                        other.stolen_slot = noone;
                        alarm[3] = 1;
                        other.force_used = other.force;
                    }    
                }
                */
            }
        }

        // RETURN GRAVITY BACK TO NORMAL
        else if (self.gravity_coef != self.old_coef || self.gravity_direction != 270) {
            self.gravity_direction = 270;
            self.gravity_coef = self.old_coef;
            self.y -= 1;
            self.airborne = false;
        }
    }
}
