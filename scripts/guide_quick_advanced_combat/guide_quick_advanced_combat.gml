///@param method
///@param [near_guy]
///@param [selected_subtask]
function guide_quick_advanced_combat() {
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
            main_quest_id = "quick_tutorial_advanced_combat";
            main_context = "quick_tut_level5";
        
            npc_auto_demonstrate = true;
        
            break;
        
        
        case "demo_after_speech":
            if(selected_subtask == "red_color_body")
            {
                if(my_color != g_red)
                {
                    if(current_slot == 0)
                    {
                        ds_list_add(new_colors, g_red);
                        self.auto_chosen_orbs = true;
                    }
                    wanna_cast = true;
                }
            }
    
            if(selected_subtask == "dark_color_body")
            {
                if(my_color == g_dark)
                {
                    ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                    self.auto_chosen_orbs = true;
            
                    wanna_cast = true;
                }   
            
            
                if(my_color != g_dark)
                {
                    wanna_channel = true;
                }
            }
            
            if(selected_subtask == "shield_pickup")
            {
                if(my_color != g_dark && tint_updated)
                {
                    wanna_channel = true;
                }
            
                if(my_color == g_dark)
                {
                    var target = instance_nearest(x,y, shield_item_obj);
                    
                    if(instance_exists(target))
                    {
                        desired_aim_dir = point_direction(x,y, target.x, target.y);
                        desired_aim_dist = 1;
                    
                        if(!casting && charge_ball.energy < 0.8 && !instance_exists(black_projectile_obj))
                        {
                            wanna_cast = true;
                        }
                    }
                }
            }
        
            if(selected_subtask == "get_past_guards")
            {
                if(my_color == g_dark || (!charging && !casting))
                {
                    ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                    self.auto_chosen_orbs = true;
                }
            
                wanna_cast = true;
            }
        
            if(selected_subtask == "use_invis")
            {
                if(my_color != g_cyan)
                {
                    ds_list_add(new_colors, g_green, g_blue);
                    self.auto_chosen_orbs = true;
                
                    wanna_cast = true;
                }
                /*
                if(speaking && nearest_waypoint.waypoint_id == "use_invis/active" && !invisible)
                {
                    abi_cooldown[? g_cyan] = 0;
                }
                */
                if(my_color == g_cyan && tint_updated && !speaking && !invisible && nearest_waypoint.waypoint_id == "use_invis/active") //  && abi_cooldown[? g_cyan] == 0
                {
                    abi_cooldown[? g_cyan] = 0;
            
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
            
                if(my_color == g_blue && tint_updated && npc_waypoint == "use_teleport/active")
                {
                    desired_aim_dir = 0;
                    desired_aim_dist = 1;
                }
            
            }
        
        
            break;
        
        case "non_demo":
    
            // KEEP ORBS ON AT LEAST BASE ENERGY
            var col, list, orb;
            for (col = g_red; col <= g_blue; col++)
            {
                if(col == g_yellow)
                {
                    continue;
                }
                
                list = orbs_in_use[? col];
                if(!is_undefined(list) && ds_exists(list, ds_type_list))
                {
                    var count = ds_list_size(list);
                    for(i=0; i < count; i++)
                    {
                        orb = list[| i];
                    
                        if(orb.energy < orb.base_energy)
                        {
                            orb.energy = orb.base_energy;
                        }
                    }
                }
            }
    
            if(selected_subtask == "dark_color_body")
            {
                if(my_color == g_dark && npc_waypoint == "dark_color_body/success" && npc_destination_reached)
                {
                    if(current_slot == 0)
                    {
                        ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                        self.auto_chosen_orbs = true;
                    }
                
                    wanna_cast = true;
                }  
            
                if(my_color != g_dark && current_slot > 0)
                {
                    wanna_cast = true;   
                }
            }
        
            if(selected_subtask == "shield_pickup")
            {
                if(my_color != g_dark && tint_updated)
                {
                    wanna_channel = true;
                }
            }
    
            if(selected_subtask == "use_invis")
            {
                /*
                if(!speaking && npc_waypoint == "use_invis/active") //  && npc_destination_reached
                {
                    abi_cooldown[? g_cyan] = 0;
                }
                */
            }
    
            break;
    }
}
