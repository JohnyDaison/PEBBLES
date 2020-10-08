/// @description receive_damage(amount)
/// @function receive_damage
/// @param amount
function receive_damage() {
	var dmg,dmg_ok,dmg_mod,shield_ratio,shield_dmg = 0,big_beam,got_hit,aiming,center_dist,center_dir;
	var x_dist,y_dist,hspeed_boost,vspeed_boost,body_dmg,healed, final_damage = 0;
	var ret = false, dash_coef = 12;

	dmg = argument[0];
	big_beam = false;
	if(argument_count > 1)
	{
	    big_beam = argument[1];
	}

	dmg_ok = false;
	dmg_mod = 1;
	shield_ratio = 0;
	got_hit = false;

	hspeed_boost = 0;
	vspeed_boost = 0;

	if(instance_exists(other.my_guy))
	{
	    //my_console_log("DAMAGE - ENEMY ? " + string(other.my_guy != id));
	    // CHECK IF TARGET IS VALID
	    if(object_is_ancestor(other.object_index, projectile_obj))
	    {
	        //my_console_log("PROJECTILE HIT");
        
	        if((other.my_guy != id || has_left_me(other)) && !other.collided)
	        {
	            dmg_ok = true;
	        }
	    }
	    else
	    {
	        //my_console_log("OTHER HIT");
	        if(other.my_guy != id)
	        {
	            dmg_ok = true;
	        }
	    }
    
	    /*
	    if(!dmg_ok)
	    {
	        my_console_log("DAMAGE TARGET NOT VALID");
	    }
	    */
    
	    if(dmg_ok && !self.protected)
	    {
	        // BEAM LOCKING
	        /*
	        if(other.object_index == beam_obj && big_beam)
	        {
	            self.locked = true; 
	        }
	        */
        
	        if(!is_shielded(self) || other.object_index == energy_smoke_obj)
	        {
	            got_hit = true;
	        }
	        else
	        {
	            // SMALL BOLT VS SHIELD BUFF
	            /*
	            if(other.object_index == small_projectile_obj)
	            {
	                dmg_mod *= 1.5;
	            }
	            */
            
	            // BEAM VS SHIELD DEBUFF
	            if(other.object_index == beam_obj)
	            {
	                dmg_mod *= 0.75;
	            }
            
	            shield_ratio = get_power_ratio(other.my_color,my_shield.my_color);

	            // ARC VS SHIELD DEBUFF
	            if(other.object_index == energy_burst_obj)
	            {
	                if(shield_ratio > 0)
	                    dmg_mod *= 0.1;
	                if(shield_ratio < 0)
	                    dmg_mod *= 0.3;
	            }
            
	            shield_dmg = dmg*dmg_mod*shield_ratio;
	            last_damage_tint = ds_map_find_value(DB.colormap,other.my_color);
	            damage_tint_alpha = 1;
	            if(my_shield.charge < shield_dmg)
	            {
	                if(other.object_index == aoe_obj)
	                    other.force_used += my_shield.charge;
	                dmg -= my_shield.charge/(dmg_mod*shield_ratio);
	                my_shield.charge -= shield_dmg;
	                //my_shield.done_for = true;
	                //got_hit = true;
	                last_shield_color = my_shield.my_color;
	                last_shield_break_color = other.my_color;
                
	                if(other.object_index != energy_burst_obj)
	                {
	                    last_attacker_update(other.id, "shield", "damage");
	                }
	                if(other.object_index == beam_obj)
	                    other.alarm[0]=2;

	                if(shield_ratio != 0)
	                {
	                    my_sound_play(shield_break_sound);
	                }
	            }
	            else
	            {
	                my_shield.charge -= shield_dmg;
	                //got_hit = false;
	                if(other.object_index == aoe_obj)
	                    other.force_used += dmg*dmg_mod;
	                dmg = 0;
	                if(other.object_index != beam_obj && shield_ratio != 0)
	                {
	                    //my_sound_play_colored(shield_hit_sound, other.my_color);
	                    my_sound_play(shield_hit_sound);
	                }
	                if(other.object_index != energy_burst_obj)
	                {
	                    last_attacker_update(other.id, "shield", "damage");
	                }
	                // SHIELD IMPACT
	                my_shield.impact_draw = true;
	                my_shield.impact_newtint = ds_map_find_value(DB.colormap, other.my_color);
	                my_shield.impact_newdir = point_direction(x,y, other.xprevious,other.yprevious);
	            }
            
	            // DAMAGE POPUP
	            if(shield_dmg != 0 && object_is_ancestor(other.object_index, projectile_obj))
	            {
	                create_damage_popup(shield_dmg, other.my_color, id);
	                /*
	                i = instance_create(other.x,other.y,damage_popup_obj);
	                i.damage = shield_dmg;
	                i.my_color = other.my_color;
	                i.tint_updated = false;
	                i.source = id;
	                */
	            }
            
	            // BEAM VS SHIELD UNDEBUFF
	            if(other.object_index == beam_obj)
	            {
	                dmg_mod /= 0.75;
	            }
            
	            /*
	            // SMALL BOLT VS SHIELD UNBUFF
	            if(other.object_index == small_projectile_obj)
	            {
	                dmg_mod /= 1.5;
	            }
	            */
            
	            // BIG BOLT VS SHIELD
	            if(other.object_index == big_projectile_obj)
	            {
	                boost_ratio = 0.15;

	                hspeed_boost = shield_dmg * (other.hspeed / 2) * (self.damage + 1) * boost_ratio;
	                vspeed_boost = shield_dmg * ((y - other.y) / 16 - 1) * (self.damage + 1) * boost_ratio;

	                if(!immovable)
	                {
	                    if (!place_meeting(x + sign(hspeed + hspeed_boost), y + sign(vspeed + vspeed_boost), terrain_obj))
	                    {
	                        hspeed += hspeed_boost;
	                        vspeed += vspeed_boost;
	                    }
	                    else if (!place_meeting(x + sign(hspeed + hspeed_boost), y, terrain_obj))
	                    {
	                        hspeed += hspeed_boost;
	                    }
	                }
	            }

	            // BEAM VS SHIELD PUSH
	            if(other.object_index == beam_obj)
	            {
	                hspeed_boost = other.my_guy.facing*sqrt(self.damage+1)/25;

	                if(!immovable)
	                {
	                    if (!place_meeting(x + hspeed + hspeed_boost + other.my_guy.facing, y + vspeed, terrain_obj))
	                    {
	                        hspeed += hspeed_boost;
	                    }
	                }
	            }
            
	            // DASHWAVE VS SHIELD PUSH
            
	            if(other.object_index == dash_wave_obj && other.knockback)
	            {
	                x_dist_ratio = lengthdir_x(dash_coef, other.image_angle);
	                y_dist_ratio = lengthdir_y(dash_coef, other.image_angle);
                
	                hspeed_boost = x_dist_ratio;
	                vspeed_boost = y_dist_ratio;
                
	                if(!immovable)
	                {
	                    hspeed += hspeed_boost;
	                    vspeed += vspeed_boost;
	                }
	            }
            
	            if(other.object_index == dash_wave_obj && object_is_ancestor(object_index,guy_obj) && self.channeling)
	            {
	                self.interrupt_channel = true;
	            }
	        }

	        // BODY HIT
        
	        if(got_hit)
	        {
	            var back_col = false;
	            // SPELL INIT

	            // LOST CONTROL - SHIELD, BEAM, IMPACT
	            if (object_is_ancestor(object_index,guy_obj))
	            {
	                if (other.object_index == shield_obj && other.my_color != my_color && !berserk) // other.object_index == big_projectile_obj  ||
	                {
	                    self.lost_control = true;
	                    if (sign(x - other.x) == self.facing)
	                    {
	                        self.back_hit = true;
	                    }
	                    else
	                    {
	                        self.front_hit = true;
	                    }
	                }

	                if (other.object_index == beam_obj && big_beam && !berserk)
	                {
	                    if (my_color != other.my_color)
	                    {
	                        self.lost_control = true;
	                        self.hit_handled = false;
	                        if (other.head_facing == self.facing)
	                        {
	                            self.back_hit = true;
	                        }
	                        else
	                        {
	                            self.front_hit = true;
	                        }
	                    }
	                    if (!airborne)
	                    {
	                        y -= 3;
	                    }
	                }    
	            }
            
	            if(other.object_index == impact_obj)
	            {
	                if (object_is_ancestor(object_index,guy_obj) && !berserk)
	                {
	                    if (!self.lost_control)
	                    {
	                        self.lost_control = true;
	                        if (sign(x - other.x) == self.facing)
	                        {
	                            self.back_hit = true;
	                            show_debug_message("rear impact hit");
	                        }
	                        else
	                        {
	                            self.front_hit = true;
	                            show_debug_message("frontal impact hit");
	                        }
	                    }
	                }

	                center_dist = point_distance(other.x, other.y, x, y);
	                center_dir = point_direction(other.x, other.y, x, y);
	                x_dist = lengthdir_x(center_dist, center_dir);
	                y_dist = lengthdir_y(center_dist, center_dir);
	            }
            
	            if(other.object_index == lightning_strike_obj)
	            {
	                if (object_is_ancestor(object_index,guy_obj) && !berserk)
	                {
	                    if (!self.lost_control)
	                    {
	                        self.lost_control = true;
	                        if (sign(x - other.x) == self.facing)
	                        {
	                            self.back_hit = true;
	                            show_debug_message("rear impact hit");
	                        }
	                        else
	                        {
	                            self.front_hit = true;
	                            show_debug_message("frontal impact hit");
	                        }
	                    }
	                }

	                center_dist = point_distance(other.x, other.y, x, y);
	                center_dir = point_direction(other.x, other.y, x, y);
	                x_dist = lengthdir_x(center_dist, center_dir);
	                y_dist = lengthdir_y(center_dist, center_dir);
	            }
                
	            if(other.object_index == aoe_obj)
	            {
	                if(other.aiming_up)
	                {
	                    aiming = -1;
	                }
	                if(other.aiming_down)
	                {
	                    aiming = 1;
	                }

	                center_dist = point_distance(other.x,other.y,x,y);
	                if(center_dist>123)
	                    center_dist = 123;
	            }

	            // COMPUTE SPELL TO BODY
	            power_ratio = get_power_ratio(other.my_color,my_color);

	            // ARC VS BODY DEBUFF
	            if(other.object_index == energy_burst_obj)
	            {
	                if(power_ratio > 0)
	                    dmg_mod *= 0.1;
	                if(power_ratio < 0)
	                    dmg_mod *= 0.2;
	            }

	            body_dmg = dmg*power_ratio;
	            healed = (body_dmg < 0);
            
	            var big_proj_boost_modifier = 1.5;
	            var small_proj_boost_modifier = 0.5;
	            var boost_mod = dmg_mod;

	            if(healed)
	            {
	                body_dmg *= -1;
	            }

	            if(body_dmg > 0)
	            {
	                // COMPUTE BOOST
	                if(!immovable)
	                {
	                    // BOOST MODIFIERS                 
	                    if(other.object_index == big_projectile_obj)
	                    {
	                        boost_mod *= big_proj_boost_modifier;
	                    }  
    
	                    if(other.object_index == small_projectile_obj)
	                    {
	                        boost_mod *= small_proj_boost_modifier;
	                    }
                    
	                    // ENERGY BALLS
	                    // TODO: this is magic, introduce science
	                    if(object_is_ancestor(other.object_index, energyball_obj))
	                    {
	                        var rel_hspeed;
	                        back_col = sign(other.xprevious - self.xprevious) == sign(other.hspeed); // maybe my hspeed?
	                        if(back_col)
	                        {
	                            rel_hspeed = -self.hspeed*2;
	                        }
	                        else
	                        {
	                            rel_hspeed = other.hspeed-self.hspeed;
	                        }
	                        hspeed_boost = body_dmg * boost_mod * (rel_hspeed/4) * (self.damage+1);
	                        vspeed_boost = body_dmg * boost_mod * ((y-other.y)/16-1) * (self.damage+1);
	                    }
    
	                    // AoE
	                    if(other.object_index == aoe_obj)
	                    {
	                        hspeed_boost = (self.damage+1) * body_dmg * boost_mod * ((x-other.x)/16);
	                        vspeed_boost = (self.damage+1) * aiming * body_dmg * boost_mod * (144-center_dist)/16;
	                    }
    
	                    // BEAM
	                    if(other.object_index == beam_obj)
	                    {
	                        hspeed_boost = other.head_facing * sqrt(self.damage+1)/15;
	                        if(big_beam) {
	                            vspeed_boost = -1/( 4 + (other.y-y)/other.beam_big_core_size );
	                            if(object_is_ancestor(object_index, guy_obj))
	                            {
	                                var cam = my_player.my_camera;
	                                if(instance_exists(cam))
	                                {
	                                    if(cam.shake_dist <= 0)
	                                    {
	                                        cam.shake_dist = 10; 
	                                        cam.shake_dir = ((other.facing+1)*90) mod 360;
	                                    }
	                                    else
	                                    {
	                                        cam.shake_dist += cam.shake_dist_decay*1.1; 
	                                    }
	                                }
	                            }
	                        }
	                        else
	                            vspeed_boost = 0;
	                    }
    
	                    // SHIELD
	                    if(other.object_index == shield_obj)
	                    {
	                        if(instance_exists(other.my_guy))
	                        {
	                            hspeed_boost = body_dmg*boost_mod*(other.my_guy.hspeed/2+((x-other.x)/8))*(self.damage+1);
	                            vspeed_boost = body_dmg*boost_mod*(other.my_guy.vspeed/2+((y-other.y)/8-2))*(self.damage+1);
	                        }
	                        else
	                        {
	                            hspeed_boost = body_dmg*boost_mod*(other.hspeed/2+((x-other.x)/8))*(self.damage+1);
	                            vspeed_boost = body_dmg*boost_mod*(other.vspeed/2+((y-other.y)/8-2))*(self.damage+1);
	                        }
	                    }
    
	                    // IMPACT
	                    if(other.object_index == impact_obj)
	                    {
	                        x_dist_ratio = (sign(x_dist) - x_dist/(2*other.inner_radius))*other.impact_force;
	                        y_dist_ratio = (sign(y_dist) - y_dist/(2*other.inner_radius))*other.impact_force;
    
	                        hspeed_boost = self.damage+1;
	                        vspeed_boost = self.damage+1;
    
	                        if(x_dist != 0 && y_dist != 0)
	                        {
	                            hspeed_boost *= 3*x_dist_ratio * abs(y_dist_ratio);
	                            vspeed_boost *= abs(x_dist_ratio) * 1.5*y_dist_ratio;
	                        }
	                        else
	                        {
	                            if(x_dist == 0)
	                            {
	                                hspeed_boost *= 0;
	                            }
	                            else
	                            {
	                                hspeed_boost *= 3*x_dist_ratio;
	                            }
    
	                            if(y_dist == 0)
	                            {
	                                vspeed_boost *= 1.5;
	                            }
	                            else
	                            {
	                                vspeed_boost *= 1.5*y_dist_ratio;
	                            }
	                        }
	                    }
                    
	                    // LIGHTNING STRIKE
	                    if(other.object_index == lightning_strike_obj)
	                    {
	                        x_dist_ratio = (sign(x_dist) - x_dist/(2*other.radius))*other.impact_force;
	                        y_dist_ratio = (sign(y_dist) - y_dist/(2*other.radius))*other.impact_force;
    
	                        hspeed_boost = self.damage+1;
	                        vspeed_boost = self.damage+1;
    
	                        if(x_dist != 0 && y_dist != 0)
	                        {
	                            hspeed_boost *= 3*x_dist_ratio * abs(y_dist_ratio);
	                            vspeed_boost *= abs(x_dist_ratio) * 1.5*y_dist_ratio;
	                        }
	                        else
	                        {
	                            if(x_dist == 0)
	                            {
	                                hspeed_boost *= 0;
	                            }
	                            else
	                            {
	                                hspeed_boost *= 3*x_dist_ratio;
	                            }
    
	                            if(y_dist == 0)
	                            {
	                                vspeed_boost *= 1.5;
	                            }
	                            else
	                            {
	                                vspeed_boost *= 1.5*y_dist_ratio;
	                            }
	                        }
	                    }
                    
	                    // DASHWAVE END
	                    if(other.object_index == dash_wave_obj && other.knockback)
	                    {
	                        var back_col = facing == sign(lengthdir_x(1, other.image_angle));
                        
	                        x_dist_ratio = lengthdir_x(dash_coef, other.image_angle);
	                        y_dist_ratio = lengthdir_y(dash_coef, other.image_angle);
                        
	                        hspeed_boost = x_dist_ratio;
	                        vspeed_boost = y_dist_ratio;
	                    }
                    
	                    // APLLY BOOST
	                    var boost_coef = 2;
                
	                    if (!place_meeting(x + sign(hspeed + hspeed_boost*boost_coef), y + sign(vspeed + vspeed_boost*boost_coef), terrain_obj))
	                    {
	                        hspeed += hspeed_boost*boost_coef;
	                        vspeed += vspeed_boost*boost_coef;
	                    }
	                    else if (!place_meeting(x + sign(hspeed + hspeed_boost*boost_coef), y, terrain_obj))
	                    {
	                        hspeed += hspeed_boost*boost_coef;
	                    }
                    
	                    if(speed > max_speed)
	                    {
	                        speed = max_speed;   
	                    }
	                }
	            }
            
            

	            if(healed)
	            {
	                body_dmg *= -1;
	            }

	            if(object_is_ancestor(object_index,guy_obj))
	            {
	                // PROJECTILES AND DASH LOST CONTROL
	                if ((object_is_ancestor(other.object_index, projectile_obj) || other.object_index == dash_wave_obj) && !berserk)
	                {
	                    if (point_distance(0, 0, hspeed_boost, vspeed_boost) > lost_control_boost_threshold || body_dmg > lost_control_damage_threshold
	                    || (other.object_index == dash_wave_obj && self.channeling))
	                    {
	                        self.lost_control = true;
	                        if (back_col)
	                        {
	                            self.back_hit = true;
	                        }
	                        else
	                        {
	                            self.front_hit = true;
	                        }
	                    }
	                }

	                // SPECIAL EFFECT
	                spec_effect_to_guy(body_dmg*dmg_mod, "damage");
	            }
            
            
	            // DAMAGE MODIFIERS
	            var big_proj_damage_modifier = 1.25;
            
	            if(other.object_index == big_projectile_obj)
	            {
	                dmg_mod *= big_proj_damage_modifier;
	            }
    
	            // ACTUAL DAMAGE
	            final_damage = body_dmg*dmg_mod;
	            var orig_damage = damage;
	            self.damage += final_damage;
	            self.damage = max(0,self.damage);
	            if(object_is_ancestor(object_index, guy_obj))
	            {
	                self.damage = max(self.min_damage, self.damage);
	            }
	            self.last_damage_tint = ds_map_find_value(DB.colormap,other.my_color);
	            self.damage_tint_alpha = 1;
            
	            self.tint = merge_color(ds_map_find_value(DB.colormap,my_color),last_damage_tint,damage_tint_ratio);
	            self.tint_updated = false;
            
	            if(object_is_ancestor(object_index, guy_obj))
	            {
	                if(final_damage > 0)
	                { 
	                    my_player.spell_dmg_total += final_damage;
	                }
                                
	                if(final_damage < 0)
	                {
	                    my_player.healed_dmg_total += orig_damage - damage;
	                }
	            }
            
	            // UPDATE
	            if(other.object_index == aoe_obj)
	                other.force_used += dmg*dmg_mod;
                
	            if(other.object_index == energy_smoke_obj)
	                other.force = max(0, other.force - other.force_usage);
                
	            if(other.my_player.object_index == player_obj)
	            {
	                if(other.object_index != energy_burst_obj || last_attacker_map[? "source"] == noone)
	                {
	                    last_attacker_update(other.id, "body", "damage");
	                }
                
	                var la_player = last_attacker_map[? "player"];
	                var what = last_attacker_map[? "source"];
                
	                if(what == guy_obj)
	                {
	                    if(final_damage > 0)
	                    {
	                        la_player.dealt_dmg_total += final_damage;
	                    }
	                }
	            }
            
	            if(other.object_index == dash_wave_obj)
	            {
	                // COOLDOWN DAMAGE
	                if (object_is_ancestor(object_index,guy_obj) && !berserk)
	                {
	                    if(other.my_color >= g_black && other.my_color <= g_white)
	                    {
	                        abi_cooldown[? other.my_color] = clamp(abi_cooldown[? other.my_color] + round(cooldown_damage_coef*final_damage), 0, abi_cooldown_length[? other.my_color]);
	                    }
	                }
	            }
            
	            // SLIME CHARGING
	            if(object_index == slime_mob_obj)
	            {
	                energy += abs(final_damage);
	            }
            
	            // DAMAGE POPUP
	            if(final_damage != 0)
	            {
	                create_damage_popup(final_damage, other.my_color, id);
	            }
            
	            // SFX
	            if(object_is_ancestor(other.object_index,energyball_obj) || other.object_index == aoe_obj
	               || other.object_index == impact_obj)
	            {
	                //my_sound_play_colored(hit_sound, other.my_color);
	                my_sound_play(hit_sound);
	            }    
                
	            if(other.object_index == slime_mob_obj)
	            {
	                //my_sound_play_colored(wall_hum_sound, other.my_color);
	                my_sound_play(wall_hum_sound);
	            }
                
	            // VIEWSHAKE
            
	            if(other.object_index == big_projectile_obj)
	            {
	                other.impact_strength = abs(final_damage);
	            }
	        }  
    
	        // HIT BODY OR SHIELD
	        if(got_hit || shield_ratio != 0)
	        {
	            // BOLT COLLIDED
	            if(object_is_ancestor(other.object_index, energyball_obj))
	            {
	                other.collided = true;
	                if(shield_ratio != 0)
	                    other.shield_hit = true;
	            }
            
	            // DASHWAVE
	            if(other.object_index == dash_wave_obj)
	            {
	                other.dealt_damage = true; 
	                other.fading_out = true;
	            }
            
	            // SLIME TOUCH
	            if(other.object_index == slime_mob_obj)
	            {
	                other.energy -= abs(max(shield_dmg, final_damage));
	            }
            
	            ret = true;
	        }
	    }
	}
	else
	{
	    my_console_log("Damage: other.my_guy nonexistant");
	    if(other.my_guy != noone)
	    {
	        with(other)
	        {
	            instance_destroy();
	        }
	    }
	}

	return ret;



}
