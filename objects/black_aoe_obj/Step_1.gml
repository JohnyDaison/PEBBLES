event_inherited();

with(guy_obj)
{
    if(holographic == other.holographic)
    {
        dist = point_distance(x,y,other.x,other.y);
        if(old_coef == 0)
        {
            old_coef = self.gravity_coef;
        }
        
        ubershielded = is_shielded(id, "uber");
        
        if(dist < other.radius)
        {
            if(ubershielded)
            {             
                my_shield.charge -= 0.01;
                my_sound_play(wall_hum_sound, true);
                //my_sound_play_colored(wall_hum_sound, my_shield.my_color, true);
            }
            
            if(self.id != other.my_guy && other.force > 0 && !ubershielded && !protected)
            {        
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
                            slot.sprite_index = noone;
                        }
                        
                        alarm[3] = 1;
                        show_debug_message("Loser!");
                        
                        ds_list_add(other.stolen_slots,other.slot.id);
                        other.slot_count = ds_list_size(other.stolen_slots);
                    }
                }
                */
                
                // THROWING AROUND
                if(!protected && !stuck && !hit_handled) // && speed < max_speed
                {
                    gravity_direction = point_direction(x,y,other.x,other.y);
                    /*
                    if(dist < other.radius/6)
                    {
                        dist = other.radius/6;
                    }
                    */
                    gravity_coef = abs((1 - dist/other.radius))*2*other.force;
                    if(vspeed == 0)
                        vspeed = sign(other.y-y);
                    
                    if(!lost_control)
                    {
                        if(sign(lengthdir_x(dist,gravity_direction)) == facing)
                        {
                            back_hit = true;
                        }
                        else
                        {
                            front_hit = true;
                        }
                    }
                    if(airborne)
                    {
                        lost_control = true;
                    }
                    
                    last_attacker_update(other.id, "body", "push");
                }
                
                
            }
            else
            {
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
        else if(gravity_coef != old_coef || gravity_direction != 270)
        {
            gravity_direction = 270;
            gravity_coef = old_coef;
            y -= 1;
            airborne = false;
        }
    }
}

/* */
/*  */
