///@param method
///@param [near_guy]
///@param [selected_subtask]
function guide_quick_catalyst2() {
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
    
    var color_change_delay = 120;
    static last_color_change = -1;

    switch(pseudo_method)
    {
        case "init":
            main_quest_id = "quick_tutorial_catalyst";
            main_context = "quick_tut_level3";
        
            npc_auto_demonstrate = true;
        
            break;
        
        
        case "demo_after_speech":
            if(selected_subtask == "color_body" || selected_subtask == "quick_shot") {
                var delay_ended = last_color_change < singleton_obj.step_count - color_change_delay;
                
                if(my_color == g_dark || delay_ended) {
                    var first_orb = color_slots[|0];
                    var ready_for_new_color = tint_updated && !slots_triggered && !charging && !casting;
                    
                    if(!is_undefined(first_orb)) {
                        if(first_orb.color_held) {
                            wanna_cast = true;
                            last_color_change = singleton_obj.step_count;
                        }
                    } else if(ready_for_new_color) {
                        var new_color = choose(g_red, g_green, g_blue);
                
                        while(new_color == my_color) {
                            new_color = choose(g_red, g_green, g_blue);
                        }
                    
                        ds_list_add(new_colors, new_color);
                        self.auto_chosen_orbs = true;
                        last_color_change = singleton_obj.step_count;
                    }
                }
            }
            
            if(selected_subtask == "quick_shot")
            {
                if(my_color != g_dark && instance_exists(charge_ball))
                {
                    var target = instance_nearest(x,y, SECRET_obj);
                    
                    if(instance_exists(target))
                    {
                        desired_aim_dir = point_direction(x,y, target.x, target.y);
                        desired_aim_dist = 1;
                    
                        if(!casting && charge_ball.energy < 0.2)
                        {
                            wanna_cast = true;
                        }
                    }
                }
            }
            
            if(selected_subtask == "jump_to_ricochet" || selected_subtask == "ricochet")
            {
                if(my_color != g_green)
                {
                    ds_list_add(new_colors, g_green);
                    self.auto_chosen_orbs = true;
                    wanna_cast = true;
                }
            }
        
            if(selected_subtask == "be_out_of_range")
            {
                if(my_color == g_dark || (!charging && !casting))
                {
                    ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                    self.auto_chosen_orbs = true;
                }
            
                wanna_cast = true;
                wanna_look = true;
                desired_aim_dir = 0;
                desired_aim_dist = 1;
                set_guy_facing(true);
            }
        
            if(selected_subtask == "battery_spawner")
            {
                var delay_ended = last_color_change < singleton_obj.step_count - color_change_delay;
                
                if(my_color == g_dark || delay_ended)
                {
                    if(my_color == g_dark || (!charging && !casting))
                    {
                        ds_list_add(new_colors, choose(g_red, g_green, g_blue));
                        self.auto_chosen_orbs = true;
                    }
            
                    if(!casting && instance_exists(charge_ball) && charge_ball.energy < 0.2)
                    {
                        wanna_cast = true;
                    }
                    
                    if(casting)
                    {
                        last_color_change = singleton_obj.step_count;
                    }
                }
            
                wanna_look = true;
                desired_aim_dir = 0;
                desired_aim_dist = 1;
                set_guy_facing(true);
            }
            
            if(selected_subtask == "use_terminal")
            {
                with(inventory_overlay)
                {
                    if(my_guy == near_player_guy && whole_inv_blink_time == 0)
                    {
                        whole_inv_blink_rate = 20;
                        whole_inv_blink_time = whole_inv_blink_rate*4;
                    }
                }
            }
        
            break;
        
        case "non_demo":
            if (selected_subtask == "ricochet") {
                if(my_color != g_green) {
                    ds_list_add(new_colors, g_green);
                    self.auto_chosen_orbs = true;
                    wanna_cast = true;
                }
                
                if (instance_exists(energy_burst_obj)) {
                    if (energy_burst_obj.my_color != g_green && !instance_exists(speech_popup_obj)) {
                        speech_start(main_quest_id + DB.quest_context_divider + "ricochet/failure", true, near_player_guy);
                    }
                }
            }
        
            break;
    }
}
