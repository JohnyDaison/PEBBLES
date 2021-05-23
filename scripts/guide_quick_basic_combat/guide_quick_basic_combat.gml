///@param method
///@param [near_guy]
///@param [selected_subtask]
function guide_quick_basic_combat() {
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
            main_quest_id = "quick_tutorial_basic_combat";
            main_context = "quick_tut_level4";
        
            npc_auto_demonstrate = true;
            npc_waited_steps = 0;
        
            break;
        
        
        case "demo_after_speech":
            if(selected_subtask == "barrage_shot")
            {
                if(nearest_waypoint.waypoint_id == "barrage_shot/active")
                {
                    if(my_color == g_dark || (tint_updated && !slots_triggered && !charging && !casting && current_slot == 0))
                    {
                        var last_color = g_nothing;
                        var new_color = g_nothing;
                    
                        while(ds_list_size(new_colors) < 2)
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
                }
                /*
                if(my_color == g_dark || (tint_updated && !slots_triggered && !charging && !casting))
                {
                    ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                    ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                    self.auto_chosen_orbs = true;
                    wanna_cast = true;
                }
                */
                if(nearest_waypoint.waypoint_id == "barrage_shot/success")
                {
                    if(current_slot != 0 || charging || casting)
                    {
                        desired_aim_dir = 30 + 60 * (charge_ball.energy/charge_ball.orb_exhaustion_ratio);
                        desired_aim_dist = 1;
                    
                        if(!casting && charge_ball.energy < (charge_ball.max_charge * charge_ball.orb_exhaustion_ratio))
                        {
                            wanna_cast = true;
                        }
                    }
                }
            }
        
            if(selected_subtask == "channeling")
            {
                if(nearest_waypoint.waypoint_id == "channeling/active" && !demonstration_done)
                {
                    npc_waited_steps++;
            
                    if(!channeling || npc_waited_steps < 360)
                    {
                        demonstration_start = singleton_obj.step_count;   
                    }
            
                    if(!slots_triggered)
                    {
                        if(npc_waited_steps > 180 || channeling)
                        {
                            if(my_color == g_dark || (tint_updated && !channeling && current_slot == 0))
                            {
                                var last_color = g_nothing;
                                var new_color = g_nothing;
                    
                                while(ds_list_size(new_colors) < 2)
                                {
                                    new_color = choose(g_red, g_green, g_blue);
                        
                                    if(last_color != new_color)
                                    {
                                        ds_list_add(new_colors, new_color);
                                        last_color = new_color;
                                    }
                                }
                    
                                self.auto_chosen_orbs = true;
                    
                                if(my_color == g_dark)
                                {
                                    wanna_cast = true;
                                }
                            }
                            else
                            {
                                wanna_channel = true;
                                if(!channeling)
                                {
                                    npc_waited_steps = 0;
                                }
                            }
                        }
                    }
                }
            }
        
            if(selected_subtask == "dashwave_shot")
            {
                if(nearest_waypoint.waypoint_id == "dashwave_shot/active")
                {
                    if(my_color == g_dark || (tint_updated && !slots_triggered && !charging && !casting && current_slot < 3))
                    {
                        var last_color = g_nothing;
                        var new_color = g_nothing;
                    
                        while(ds_list_size(new_colors) < 3)
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
                }
                /*
                if(my_color == g_dark || (tint_updated && !slots_triggered && !charging && !casting))
                {
                    ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                    ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                    self.auto_chosen_orbs = true;
                    wanna_cast = true;
                }
                */
                if(nearest_waypoint.waypoint_id == "dashwave_shot/success")
                {
                    if(current_slot != 0 || charging || casting)
                    {
                        desired_aim_dir = 0;
                        desired_aim_dist = 1;
                    
                        if(!casting && ( !charging || charge_ball.energy < (charge_ball.max_charge + charge_ball.overcharge) * charge_ball.orb_exhaustion_ratio ))
                        {
                            wanna_cast = true;
                        }
                    }
                }
            }
        
            break;
        
        case "non_demo":
    
            // KEEP ORBS ON AT LEAST BASE ENERGY
            var col, list, orb, i;
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
    
            if(selected_subtask == "climb_tower")
            {
                //if(my_color == g_dark || (tint_updated && !slots_triggered && !charging && !casting && charge_ball.orb_exhaustion_ratio < 0.4))
                if(my_color == g_dark)
                {
                    ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                    self.auto_chosen_orbs = true;
                    wanna_cast = true;
                }
                /*
                if(my_color != g_dark)
                {
                    var target = instance_nearest(x,y, spitter_body_obj);
                    
                    if(instance_exists(target) && point_distance(x,y, target.x, target.y) < 320)
                    {
                        desired_aim_dir = point_direction(x,y, target.x, target.y);
                        desired_aim_dist = 1;
                    
                        if(!casting && charge_ball.energy < 0.5)
                        {
                            wanna_cast = true;
                        }
                    }
                }
                */
            }
        
            if(selected_subtask == "channeling_pickup")
            {
                if(current_slot > 0 && !slots_triggered)
                {
                    wanna_cast = true;   
                }
            }
        
            if(selected_subtask == "reach_dashwave")
            {
                if(current_slot > 0 && !slots_triggered)
                {
                    wanna_cast = true;   
                }
            }

            if(selected_subtask == "reach_sprinkler")
            {
                //set_guy_facing(true);
            
                if(my_color == g_dark || (tint_updated && !slots_triggered && !charging && !casting && current_slot < 3))
                {
                    var last_color = g_nothing;
                    var new_color = g_nothing;
                    
                    while(ds_list_size(new_colors) < 3)
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
                
                desired_aim_dir = 90 - facing * 60;
                //desired_aim_dir = 90 - facing * 90;
                //desired_aim_dir = point_direction(x,y, npc_waypoint_x, npc_waypoint_y - 16);
                var ang_diff = angle_difference(point_direction(x,y, npc_waypoint_x, npc_waypoint_y), desired_aim_dir);
                desired_aim_dir += ang_diff/2;
            
                desired_aim_dist = 0;
            
                /*
                if(instance_exists(nearest_waypoint) && npc_waypoint == "start_dashing" && nearest_waypoint.waypoint_id == "start_dashing" && point_distance(x,y, nearest_waypoint.x, nearest_waypoint.y) < 160)
                {
                    npc_last_waypoint = "start_dashing";
                    npc_waypoint_reached = true;
                    npc_waypoint = "reach_sprinkler/success";
                }
                */
            
                if((npc_waypoint == "start_dashing" || npc_waypoint == "reach_sprinkler/success") && airborne /*vspeed > 0*/ && !(instance_exists(landing_terrain))) //  || doublejump_count < max_doublejumps
                {
                    desired_aim_dist = 1;
                    if(!casting && (!charging || charge_ball.energy < charge_ball.max_charge * charge_ball.orb_exhaustion_ratio ) )
                    {
                        wanna_cast = true;
                    }
                }
            }
        
            if(selected_subtask == "kill_sprinkler")
            {
                if(current_slot > 0 && !slots_triggered)
                {
                    wanna_cast = true;   
                }
            }
    
            break;
    }
}
