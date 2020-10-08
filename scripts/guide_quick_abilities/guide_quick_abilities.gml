///@param method
///@param [near_guy]
///@param [selected_subtask]
function guide_quick_abilities() {
	var pseudo_method = argument[0];
	var near_player_guy = noone;
	var selected_subtask = "";

	if(argument_count > 1)
	{
	    near_player_guy = argument[1];   
	}
	if(argument_count > 2)
	{
	    selected_subtask = argument[2];   
	}

	switch(pseudo_method)
	{
	    case "init":
	        main_quest_id = "quick_tutorial_abilities";
	        main_context = "quick_tut_level6";
        
	        npc_auto_demonstrate = true;
	        flashback_disabled = false;
        
	        break;
        
	    case "demo_after_speech":
	        if(selected_subtask == "use_heal")
	        {
	            if(my_color != g_green)
	            {
	                ds_list_add(new_colors, g_green);
	                self.auto_chosen_orbs = true;
                
	                wanna_cast = true;
	            }
	            else if(current_slot > 0)
	            {
	                wanna_cast = true;
	            }
            
	            if(my_color == g_green && tint_updated && !speaking && nearest_waypoint.waypoint_id == "use_heal/active" && abi_script[? g_green] == empty_script)
	            {
	                abi_cooldown[? g_green] = 0;
            
	                wanna_abi = true;
	            }
	        }
        
	        if(selected_subtask == "use_invis")
	        {
	            if(my_color == g_azure && tint_updated && !speaking && !invisible && nearest_waypoint.waypoint_id == "use_invis/active") //  && abi_cooldown[? g_azure] == 0
	            {
	                abi_cooldown[? g_azure] = 0;
            
	                wanna_abi = true;
	            }
	        }
        
	        if(selected_subtask == "use_berserk")
	        {
	            if(!berserk)
	            {
	                if(my_color != g_red)
	                {
	                    ds_list_add(new_colors, g_red);
	                    self.auto_chosen_orbs = true;
                
	                    wanna_cast = true;
	                }
	                else if(current_slot > 0)
	                {
	                    wanna_cast = true;
	                }
              
                
	                if(my_color == g_red && !wanna_cast && tint_updated && !speaking && nearest_waypoint.waypoint_id == "use_berserk/active") //  && abi_cooldown[? g_azure] == 0
	                {
	                    abi_cooldown[? g_red] = 0;
            
	                    wanna_abi = true;
	                }
	            }
            
	            if(berserk)
	            {
	                if(my_color == g_black || (tint_updated && !slots_triggered && !charging && !casting && current_slot == 0))
	                {
	                    var last_color = g_nothing;
	                    var new_color = g_nothing;
                    
	                    while(ds_list_size(new_colors) < 1)
	                    {
	                        new_color = choose(g_red, g_green, g_blue);
                        
	                        if(last_color != new_color)
	                        {
	                            ds_list_add(new_colors, new_color);
	                            last_color = new_color;
	                        }
	                    }
                    
	                    self.auto_chosen_orbs = true;
	                }
                
	                if(current_slot != 0 || charging || casting)
	                {
	                    desired_aim_dir = 170;
	                    desired_aim_dist = 1;
                    
	                    if(!casting && charge_ball.energy < (charge_ball.max_charge * charge_ball.orb_exhaustion_ratio))
	                    {
	                        wanna_cast = true;
	                    }
	                }
	            }
	        }
        
	        if(selected_subtask == "use_haste")
	        {
	            if(my_color != g_yellow)
	            {
	                ds_list_add(new_colors, g_red, g_green);
	                self.auto_chosen_orbs = true;
                
	                wanna_cast = true;
	            }
	            else if(current_slot > 0)
	            {
	                wanna_cast = true;
	            }
            
	            if(my_color == g_yellow && tint_updated && !speaking && !has_haste && nearest_waypoint.waypoint_id == "use_haste/active")
	            {
	                abi_cooldown[? g_yellow] = 0;
            
	                wanna_abi = true;
	            }
	        }
        
	        if(selected_subtask == "use_teleport")
	        {
	            if(my_color != g_blue)
	            {
	                if(current_slot == 0)
	                {
	                    ds_list_add(new_colors, g_blue);
	                    self.auto_chosen_orbs = true;
	                }
                
	                wanna_cast = true;
	            }
	            else if(current_slot > 0)
	            {
	                wanna_cast = true;
	            }
            
	            if(my_color == g_blue && tint_updated && nearest_waypoint.waypoint_id == "use_teleport/active")
	            {
	                desired_aim_dir = 0;
	                desired_aim_dist = 1;
	            }
            
	        }
        
	        if(selected_subtask == "use_base_teleport")
	        {
	            if(my_color != g_white)
	            {
	                if(current_slot == 0)
	                {
	                    ds_list_add(new_colors, g_red, g_green, g_blue);
	                    self.auto_chosen_orbs = true;
	                }
                
	                wanna_cast = true;
	            }
	            else if(current_slot > 0)
	            {
	                wanna_cast = true;
	            }
            
	            if(my_color == g_white && tint_updated && !speaking && nearest_waypoint.waypoint_id == "use_base_teleport/active")
	            {
	                abi_cooldown[? g_white] = 0;
                
	                wanna_abi = true;
	            }
            
	        }
        
	        break;
        
        
	    case "non_demo":
	        if(selected_subtask == "use_heal")
	        {
	            with(player_guy) {
	                var subtask_state = player_quest_state_find(my_player, "",  other.main_context + DB.quest_context_divider + "use_heal", "");
	                var subtask_current_state = subtask_state[? "current_state"];
                
	                if (subtask_current_state != "success")
	                {
	                    if (damage < (min_damage + 1) ) {
	                        damage = min_damage + 2.5;   
	                    }
	                }
	            }
            
	            if (damage < (min_damage + 1) ) {
	                damage = min_damage + 2.5;   
	            }
	        }
        
	        if(selected_subtask == "use_invis")
	        {
	            if(my_color != g_azure)
	            {
	                ds_list_add(new_colors, g_green, g_blue);
	                self.auto_chosen_orbs = true;
                
	                wanna_cast = true;
	            }
	            else if(current_slot > 0)
	            {
	                wanna_cast = true;
	            }
	        }
        
	        if(selected_subtask == "use_berserk")
	        {
	            if (!demonstration_mode)
	            {
	                berserk = false;
	            }
	        }
        
	        if(selected_subtask == "use_ubershield")
	        {
	            if(my_color != g_purple)
	            {
	                ds_list_add(new_colors, g_red, g_blue);
	                self.auto_chosen_orbs = true;
                
	                wanna_cast = true;
	            }
	            else if(current_slot > 0)
	            {
	                wanna_cast = true;
	            }

	            if(my_color == g_purple && tint_updated && nearest_waypoint.waypoint_id == "use_ubershield/active" && abi_script[? g_purple] == empty_script
	            && abi_cooldown[? g_purple] < (abi_cooldown_length[? g_purple] - 2 * abi_script_delay[? g_purple]) )
	            {
	                abi_cooldown[? g_purple] = 0;
            
	                wanna_abi = true;
	            }
	        }
        
	        if(selected_subtask == "use_rewind")
	        {
	            if(my_color != g_black && !channeling)
	            {
	                wanna_channel = true;
	            }
            
	            var near_wp_dist = point_distance(x, y, nearest_waypoint.x, nearest_waypoint.y);
	            if(demonstration_mode && my_color == g_black && tint_updated && nearest_waypoint.waypoint_id == "use_rewind/success-taunt" && near_wp_dist < 64)
	            {
	                abi_cooldown[? g_black] = 0;
            
	                wanna_abi = true;
	                demonstration_mode = false;
	                phase = 0;
	                npc_waypoint = "";
	            }
	        }
        
	        if(selected_subtask == "tp_rush_a" || selected_subtask == "tp_rush_b")
	        {
	            if(!self.has_tp_rush)
	            {
	                var item = instance_create(x,y, tp_rush_obj);
	                add_to_inventory(item);
	                use_inv_item(1);
	            }
            
	            if(self.has_tp_rush && !npc_destination_reached)
	            {
	                desired_aim_dir = point_direction(x,y, npc_waypoint_x, npc_waypoint_y);
	                var dist = point_distance(x,y, npc_waypoint_x, npc_waypoint_y);
	                desired_aim_dist = 1;
	                var dist_phase = dist mod 256;
                
	                if(singleton_obj.step_count mod 30 == 0)
	                {
	                    x = npc_waypoint_x;
	                    y = npc_waypoint_y;
                    
	                    effect_create_above(ef_firework, x,y, 1, DB.colormap[? g_blue]);
	                    my_sound_play(tp_sound, true, 0.75);
	                    has_tped = true;
	                }
	            }
	        }
    
	        break;
	}



}
