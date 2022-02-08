event_inherited();

/// ANIMATION ENDS AND ENERGY REGEN
if(sprite_index != noone && image_speed > 0 && image_index+image_speed >= image_number)
{
    // ADD TO ORBIT
    if(color_added && !color_held)
    {
        color_held = true;
        color_added = false;
        if(my_guy != self.id)
        {
            my_sound_play(slot_filled_sound);
        }
    }
    
    // ABSORB
    if(!color_held && color_consumed && instance_exists(my_guy)) //&& !color_held
    {
        color_consumed = false;
        color_held = false;
        sprite_index = noone;
        image_speed = 0;
        invisible = true;
        if(object_is_ancestor(my_guy.object_index, guy_obj))
        {
            if(my_guy.abi_triggered)
            {
                //energy = max(0, energy - 0.5);
                // wrong - takes energy even if abi was not success
                
                orb_transfer(id, my_guy, "orbit", my_guy, "belt");
                
                my_guy.abi_slots_absorbed += 1;
            }
            else
            {
                if(instance_exists(my_guy.charge_ball))
                {
                    // CLEAR CHARGEBALL
                    if(my_guy.slots_absorbed == 0)
                    {
                        chargeball_orbs_return(my_guy.charge_ball);
                    }
                    
                    if(ds_list_size(my_guy.charge_ball.orbs) < my_guy.charge_ball.max_orbs)
                    {
                        orb_transfer(id, my_guy, "orbit", my_guy.charge_ball, "orbit");
                    }
                    else
                    {
                        orb_transfer(id, my_guy, "orbit", my_guy, "belt");   
                    }
                }
                else
                {
                    orb_transfer(id, my_guy, "orbit", my_guy, "belt");   
                }
    
                my_guy.slots_absorbed += 1;
                
                if(!my_guy.is_npc)
                {
                    my_sound_play(slot_absorbed_sound);
                }
                //color_in_use = true;
            }
            
            if(my_color == g_octarine)
            {
                my_guy.color_charge[? g_red] += 1;
                my_guy.color_charge[? g_green] += 1;
                my_guy.color_charge[? g_blue] += 1;
            }
            else
            {
                my_guy.color_charge[? my_color] +=1;
            }
        }
    }
}

//resonance_level = 0;
draw_lightning = false;
lightning_target = noone;
receives_lightning = false;


// ENERGY REGEN UPDATE
energy += direct_input_buffer;
direct_input_buffer = 0;

energy_regen_step = min(DB.orb_regen_speeds[? cur_regen_speed], max(0, base_energy - energy));
energy += energy_regen_step;

// ENERGY MODS
var min_lock = mod_get_state("orbs_energy_min_lock");
if (is_number(min_lock)) {
    min_lock = min_lock / 100;

    if (my_color != g_dark && energy < min_lock * base_energy)
    {
        energy = min_lock * base_energy;
    }
}

if(mod_get_state("color_orbs_energy_lock") && my_color != g_dark && energy != base_energy)
{
    energy = base_energy;
}

if(mod_get_state("dark_orb_energy_lock") && my_color == g_dark && energy != base_energy)
{
    energy = base_energy;
}


if(newly_got_steps > 0)
{
    newly_got_steps -= 1;
    
    if(newly_got_steps == 0)
    {
        with(overhead_overlay)
        {
            if(my_guy == other.my_guy)
            {
                chborbit_blink_time = chborbit_blink_rate*3;
                belts_blink_time = belt_blink_rate*3;
            }
        }   
    }
}
