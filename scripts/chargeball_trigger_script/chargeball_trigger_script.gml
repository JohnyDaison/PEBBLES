function chargeball_trigger_script() {
    var ret = false;
    //show_debug_message("TRIGGER chargeball");
    if(instance_exists(my_guy) && my_color >= g_dark && !firing && charge > 0)
    {
        var aim_direction = point_direction(0, 0, rel_x, rel_y);
    
        self.trig_charge = charge;
    
        my_guy.casting = false;
        my_guy.casting_hor = false;
        my_guy.casting_shield = false;
        my_guy.casting_up = false;
        my_guy.casting_down = false;
    
        var orb_count = 0;
        var is_guy = false;
        var is_player_guy = false;
        var inst, hboost, vboost;
    
        if(object_is_ancestor(my_guy.object_index, guy_obj))
        {
            orb_count = self.orb_count;
            is_guy = true;
            if(my_guy.id == my_player.my_guy) {
                is_player_guy = true;
            }
            // show_debug_message("orb_count: " + string(orb_count) + " my_color: " + string(my_color));
        }
        else
        {
            orb_count = my_guy.slots_absorbed;
        }
    
        if(my_color == g_dark) {
            if(orb_count > 0 && (!is_guy || has_level(my_guy, "dark_mode", 1)))
            {
                if(desired_dist == 0 && cur_dist < centered_dist)
                {
                    // DARK AOE
                    inst = instance_create(x, y, black_aoe_obj);
                    inst.my_player = self.my_player;
                    inst.force = self.charge;
                    inst.my_color = self.my_color;
                    inst.my_guy = my_guy.id;
                    inst.my_source = object_index;
                    inst.holographic = self.holographic;
                    if(my_guy != id && !my_guy.immovable) 
                    {  
                        my_guy.speed /= my_guy.running_maxspeed * 2;
                    }
                    
                    ret = true;
                    if(is_player_guy) {
                        increase_stat(my_guy.my_player, "implosion_count", 1, false);
                    }
                }
                else
                {
                    // VORTEX
                    inst = instance_create(x, y, black_projectile_obj);
                    inst.my_player = self.my_player;
                    inst.force = self.charge;
                    inst.holographic = self.holographic;
            
                    inst.direction = aim_direction;
                    inst.speed = 5 + 9 * self.charge;
                    inst.my_color = self.my_color;
                    inst.my_guy = my_guy.id;
                    inst.my_source = object_index;
                    if(my_guy != id && !my_guy.immovable)
                    {  
                        my_guy.hspeed /= 4;
                        my_guy.vspeed /= 4;
                    }
                    
                    ret = true;
                    if(is_player_guy) {
                        increase_stat(my_guy.my_player, "vortex_count", 1, false);
                    }
                }
            }
        }
        else
        {
            if(desired_dist == 0 && cur_dist < centered_dist)
            {
                // SHIELD
                if(object_is_ancestor(my_guy.object_index, guy_obj))
                {
                    if(has_level(my_guy, "shield", 1) && !my_guy.berserk && my_guy.shield_ready)
                    {
                        var play_shield_sound = false;
                        if(my_guy.my_shield == noone)
                        {
                            inst = instance_create(my_guy.x, my_guy.y, shield_obj);
                            inst.my_guy = my_guy.id;
                            inst.my_source = object_index;
                            inst.my_player = self.my_player;
                            inst.charge = self.charge;
                            inst.max_charge = my_guy.shield_max_charge;
                            inst.channel_maxboost = my_guy.shield_channel_maxboost;
                            inst.size_coef = my_guy.shield_size;
                            inst.my_color = self.my_color;
                            inst.holographic = self.holographic;
                            my_guy.my_shield = inst.id;
                            play_shield_sound = true;
                            
                            ret = true;
                        }
                        else
                        {
                            my_guy.my_shield.charge += self.charge * channelrate;
                            play_shield_sound = true;
                              
                            if(my_guy.my_shield.my_color != self.my_color)
                            {
                                my_guy.my_shield.my_color = self.my_color;
                                my_guy.my_shield.tint_updated = false;                       
                            }
                            
                            ret = true;
                        }
                    
                        if(ret)
                        {
                            if(is_player_guy) {
                                increase_stat(my_guy.my_player, "shield_count", 1, false);
                            }
                            if(play_shield_sound)
                            {
                                my_sound_play(shield_sound);
                            }
                            my_guy.casting_shield = true;
                        }
                    }
                    else
                    {
                        my_sound_play(failed_sound);                
                    }
                }
            }
            else if(!is_guy || my_guy.status_left[? "suppressed"] == 0)
            {
                // BIG BOLT
                if(orb_count == 1 && (!is_guy || has_level(my_guy, "blast_mode", 1)))
                {
                    inst = create_energy_ball(id, "big_bolt", my_color, charge);
                    inst.direction = aim_direction;
                    inst.speed = 3 + 7 * self.charge;
                
                    if(object_is_ancestor(my_guy.object_index, guy_obj))
                    {
                        viewshake(my_player.my_camera,
                            point_direction(inst.hspeed, inst.vspeed, 0, 0), 5);
                    }

                    hboost = -inst.hspeed / 10;
                    vboost = -inst.vspeed / 10;
                
                    inst.hspeed += my_guy.hspeed;
                    inst.vspeed += my_guy.vspeed;
                
                    if(my_guy != id && !my_guy.immovable) 
                    {   
                        with(my_guy)
                        {
                            hspeed += hboost;
                        
                            if(vboost <= 0 || !place_meeting(x, y + 1, terrain_obj))
                            {
                                vspeed += vboost;
                            }
                        }
                    }
                
                    ret = true;
                    if(is_player_guy) {
                        increase_stat(my_guy.my_player, "blast_count" , 1, false);
                    }
                }
            
                // BARRAGE
                if(orb_count == 2 && (!is_guy || has_level(my_guy, "barrage_mode", 1)))
                {
                    firing = true;
                    event_perform(ev_alarm,1);
                    
                    ret = true;
                    if(is_player_guy) {
                        increase_stat(my_guy.my_player, "barrage_count", 1, false);
                    }
                }
            
                // DASHWAVE

                if(orb_count == 3 && (!is_guy || has_level(my_guy, "dashwave_mode", 1)))
                {
                    if(!my_guy.airborne)
                    {
                        my_guy.y -= 1;
                        y -= 1;
                    }
                
                    inst = instance_create(x, y, dash_wave_obj);
                    inst.image_angle = aim_direction;
                    inst.image_xscale = 0.5;
                    inst.image_yscale = 0.5;
                    inst.dash_dist = dash_dist;
                    inst.my_player = self.my_player;
                    inst.force = self.charge * dash_step_ratio;
                    inst.my_color = self.my_color;
                    inst.tint_updated = false;
                    inst.my_guy = my_guy.id;
                    inst.my_source = object_index;
                    inst.holographic = self.holographic;
                
                    my_guy.air_dashing = true;
                    my_guy.speed *= 0.5;
                
                    firing = true;
                    dash_steps_left = ceil(min(charge + 0.25, 1.25) * dash_base_steps);
                    
                    ret = true;
                    if(is_player_guy) {
                        increase_stat(my_guy.my_player, "dashwave_count", 1, false);
                    }
                }

            
                // BEAM
            
                if(orb_count == 5)
                {
                    inst = instance_create(x, y, beam_obj);
                    inst.facing_right = my_guy.facing_right;
                    inst.my_player = my_player;
                    inst.force = charge;
                    inst.orig_force = charge;
                    inst.my_color = self.my_color;
                    inst.my_guy = my_guy.id;
                    inst.my_source = object_index;
                    inst.my_ball = id;
                    inst.holographic = self.holographic;
                    my_guy.my_beam = inst;          
                    my_guy.casting_beam = true;
                    firing = true;

                    ret = true;
                }
            
                // ARTILLERY SHOT
                if(orb_count == 4)
                {
                    inst = create_energy_ball(id, "artillery_shot", my_color, max_charge + overcharge);
                    inst.hspeed = rel_x;
                    inst.vspeed = rel_y;   
                    inst.speed = 5 + 7 * self.charge;
                    inst.tracked = true;
                    if(my_guy != id && !my_guy.immovable) 
                    {   
                        my_guy.hspeed -= inst.hspeed / 10;  
                        my_guy.vspeed -= inst.vspeed / 10;
                    }
                    if(my_guy.object_index == cannon_base_obj)
                    {
                        increase_stat(my_guy.my_player, "cannon_shots", 1, false);
                    
                        if(my_guy.my_guy.seated)
                        {
                            var cam = my_guy.my_player.my_camera;
                            if(instance_exists(cam))
                            {
                                cam.follow_shot = true;
                                cam.follow_guy = false;
                                cam.my_shot = inst.id;
                            }
                        }
                    }
                    ret = true;      
                }
            }
        }  
    
        if(ret)
        {
            my_guy.casting = true;
            if (!my_guy.casting_shield) {
                if (abs(rel_x) > abs(rel_y)) {
                    my_guy.casting_hor = true; 
                } else {
                    my_guy.casting_up = rel_y < 0;
                    my_guy.casting_down = rel_y > 0;
                }
            }
        
            if(is_player_guy)
            {
                increase_stat(my_guy.my_player, "spells", 1, false);
                increase_stat(my_guy.my_player, "spells" + string(my_color), 1, false);
                increase_stat(my_guy.my_player, "spellstreak", 1, false);
                increase_stat(my_guy.my_player, "combo", 1, false);
            }
        
            if(my_guy.object_index == cannon_base_obj)
            {
                with(my_guy)
                {
                    if(shot_color > g_dark)
                    {
                        orbs[? shot_color] -= 1;
                    }
                
                    // NEXT SHOT COLOR
                    var next_shot_color = shot_color,
                        orb_found = false, colors_tried = 0;
                    do
                    {
                        next_shot_color--;
                        if(next_shot_color == g_yellow) next_shot_color = g_green; 
                        if(next_shot_color < g_red)
                            next_shot_color = g_blue;
                        
                        if(orbs[? next_shot_color] >= 1)
                        {
                            shot_color = next_shot_color;
                            slots_absorbed = 4;
                            orb_found = true;
                        }
                        colors_tried++;
                    }
                    until(orb_found || colors_tried >= 3)
                
                    if(!orb_found)
                    {
                        shot_color = g_dark;
                        slots_absorbed = 0;
                    }
                }
            
                my_color = my_guy.shot_color;
                tint_updated = false;
            }
        }
        
        if(!firing)
        {
            charge = 0;
        }
        
        my_guy.charging = false;
        my_sound_stop(my_charge_sound);
        started = false;
    }
        
    return ret;
}
