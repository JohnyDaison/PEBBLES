function tut_guide3(argument0) {
    if(npc_active || phase != 0)
    {
        damage = 0;
        desired_aim_dir = 0;
        desired_aim_dist = 0;
        wanna_cast = false;
        wanna_channel = false;
        wanna_abi = false;
        speech_interrupted = false;
    
        var guided_guy = argument0;
        var pl_dist = 0;
        var player = noone;
        if(instance_exists(guided_guy))
        {
            var lowest_progress = -1;
            var lowest_mandatory_progress = -1;
            var lowest_progress_guy = noone;
            
            with(player_guy)
            {
                var main_state = player_quest_state_find(my_player, other.main_quest_id, other.main_context, "main");
    
                if (is_undefined(main_state)) {
                    continue;
                }
                
                var progress = main_state[? "subtasks_progress"];
                var mandatory_progress = main_state[? "mandatory_subtasks_progress"];
                
                if (lowest_progress == -1 || progress < lowest_progress || mandatory_progress < lowest_mandatory_progress)
                {
                    lowest_progress = progress;
                    lowest_mandatory_progress = mandatory_progress;
                    lowest_progress_guy = id;
                }
            }
            
            if (lowest_progress_guy != noone) {
                guided_guy = lowest_progress_guy;
            }
    
            if(!guided_guy.is_npc)
            {
                pl_dist = point_distance(x,y, guided_guy.x, guided_guy.y);
                player = guided_guy.my_player;
            }
        }
    
        if(instance_exists(player))
        {
            main_quest_state = player_quest_state_find(player, main_quest_id, main_context, "main");
    
            if (is_undefined(main_quest_state)) {
                return;
            }
    
            var selected_subtask = main_quest_state[? "selected_subtask"];
            var subtask_state = player_quest_state_find(player, "",  main_context + DB.quest_context_divider + selected_subtask, "");
            var subtask_current_state = subtask_state[? "current_state"];
    
            var group = get_group("waypoints");
            /*
            var waypoint_id = selected_subtask + "/" + subtask_current_state;
            var waypoint = group_find_member(group, waypoint_id);
            */
            var waypoint_id, waypoint;
        
        
            // DELAY SUBTASK CHANGES
        
            //if(selected_subtask != last_selected_subtask || subtask_current_state != last_subtask_state)
        
            if(subtask_current_state != "start")
            {
                if(selected_subtask != next_selected_subtask || subtask_current_state != next_subtask_state)
                {
                    if(last_selected_subtask == next_selected_subtask && last_subtask_state == next_subtask_state) // && !is_undefined(waypoint)
                    {
                        next_selected_subtask = selected_subtask;
                        next_subtask_state = subtask_current_state;
                        last_subtask_change = singleton_obj.step_count;
                
                        var debug_str = "1 NEXT TO " + selected_subtask + "/" + subtask_current_state;
                        my_console_log(debug_str);
                        //speech_instant(debug_str);
                    }
                }
            }
        
            var subtask_changed = last_selected_subtask != next_selected_subtask;

            if(subtask_changed || last_subtask_state != next_subtask_state)
            {
                // quick interrupt
                if(last_selected_subtask != "" && (subtask_changed || next_subtask_state == "success")
                && ((singleton_obj.step_count - last_subtask_change) > (subtask_change_fast_min_delay + irandom(subtask_change_fast_delay_range)) || subtask_changed))
                {
                    last_selected_subtask = next_selected_subtask;
                    last_subtask_state = next_subtask_state;
                
                    grab_attention_mode = false;
                    grab_attention_done = true;
                
                    demonstration_mode = false;
                    demonstration_done = true;
                
                    speech_interrupted = true;
                    has_spoken = false;
                    has_autospoken = false;
                    npc_stuck = false;
                
                    if(phase != 0)
                    {
                        phase = 0;   
                    }
                
                    var debug_str = "2 QUICK - LAST TO " + last_selected_subtask + "/" + last_subtask_state;
                    my_console_log(debug_str);
                    //speech_instant(debug_str);
                }
            
                // slow cycling
                if((singleton_obj.step_count - last_subtask_change) > (subtask_change_min_delay + irandom(subtask_change_delay_range)))
                {
                    last_selected_subtask = next_selected_subtask;
                    last_subtask_state = next_subtask_state;
                
                    var debug_str = "3 SLOW - LAST TO " + last_selected_subtask + "/" + last_subtask_state;
                    my_console_log(debug_str);
                    //speech_instant(debug_str);
                }

                if(last_selected_subtask != "" && last_subtask_state != "")
                {
                    selected_subtask = last_selected_subtask;
                    subtask_state = player_quest_state_find(player, "",  main_context + DB.quest_context_divider + selected_subtask, "");
                    subtask_current_state = last_subtask_state;
                
                    var debug_str = "4 CURRENT TO " + selected_subtask + "/" + subtask_current_state;
                    my_console_log(debug_str);
                    //speech_instant(debug_str);
                }
            }
    
    
            // TASKS HANDLING
            if(demonstration_mode)
            {
                if(npc_destination_reached && has_spoken)
                {
                    script_execute(topic, "demo_after_speech", guided_guy, selected_subtask);
                }
            }
    
    
            // TASKS - NON-DEMONSTRATION
            script_execute(topic, "non_demo", guided_guy, selected_subtask);
        
        
            // GENERAL PROBLEM SOLVING
            if((status_left[? "frozen"] > 0 || sliding || wall_sliding) && my_color != g_blue)
            {
                if(current_slot == 0 && !slots_triggered)
                {
                    ds_list_add(new_colors, g_blue);
                    self.auto_chosen_orbs = true;
                }
                wanna_cast = true;
            }
            else if(status_left[? "slow"] > 0 && my_color != g_green)
            {
                if(current_slot == 0 && !slots_triggered)
                {
                    ds_list_add(new_colors, g_green);
                    self.auto_chosen_orbs = true;
                }
                wanna_cast = true;
                wanna_jump = !wanna_jump;
            }
            else if(status_left[? "burn"] > 0 && my_color != g_red)
            {
                if(current_slot == 0 && !slots_triggered)
                {
                    ds_list_add(new_colors, g_red);
                    self.auto_chosen_orbs = true;
                }
                wanna_cast = true;
            }
            else if(status_left[? "suppressed"] > 0 && my_color != g_magenta)
            {
                if(current_slot == 0 && !slots_triggered)
                {
                    ds_list_add(new_colors, g_red, g_blue);
                    self.auto_chosen_orbs = true;
                }
                wanna_cast = true;
            }
    
            // debug
            /*
            var dstate = "NORMAL";
            var demo_time = 0;
            if(demonstration_mode)
            {
                dstate = "DEMO";
                demo_time = max(0, singleton_obj.step_count - demonstration_start);
            }
        
            name = string(phase) + " " + dstate + " " + string(demo_time) + "\n"
                    + last_selected_subtask + "/" + last_subtask_state + "\n"
                    + selected_subtask + "/" + subtask_current_state + "\n"
                    + next_selected_subtask + "/" + next_subtask_state;
            //name = "SPEAKING " + string(speaking) + " DEMO " + string(demonstration_mode);
            */
        
        
            // PHASES
            waypoint_id = selected_subtask + "/" + subtask_current_state;
            waypoint = group_find_member(group, waypoint_id);
    
            var cur_reps = subtask_state[? "state_reps"];
            var failure_count = cur_reps[? "failure"];
            var failure_limit = subtask_state[? "guide_failure_limit"];
        
            if(npc_auto_demonstrate)
            {
                failure_limit = 0;
            }
        
            if(failure_limit == -1)
            {
                failure_limit = 100;
            }

            /*
            if(!npc_destination_reached)
            {
                has_spoken = false;
            }
            */

            switch(phase)
            {
                // normal behaviour
                case 0:
                {
                    // CATCH UP WITH SKIPPED QUESTS
                
                    var guide_quest_state = player_quest_state_find(my_player, main_quest_id, main_context, "main");
                
                    if(main_quest_state[? "subtasks_progress"] > guide_quest_state[? "subtasks_progress"]
                    || main_quest_state[? "mandatory_subtasks_progress"] > guide_quest_state[? "mandatory_subtasks_progress"])
                    {
                        /*
                        if(!speaking && !has_spoken)
                        {
                            speech_start("BEHIND IN SUBTASKS");
                        }
                        */
                    
                        var main_node, sub_i, subtasks_list, subtask_count, subtask_id, context, quest_state, quest_node;
                    
                        main_node = DB.quest_nodes[? (guide_quest_state[? "quest_id"])];
                        subtask_count = main_quest_state[? "subtasks_progress"];
                        subtasks_list = main_node[? "subtasks_list"];
                    
                        for(sub_i = 0; sub_i < subtask_count; sub_i++)
                        {
                            subtask_id = subtasks_list[| sub_i];
                        
                            context = main_context + DB.quest_context_divider + subtask_id;
                            //subtask = subtasks[? subtask_id];
                            quest_state = player_quest_state_find(my_player, "", context, "");
                            quest_node = DB.quest_nodes[? (quest_state[? "quest_id"])];
                        
                            if(!(quest_state[? "current_state"] == "success" || (quest_state[? "current_state"] == "active" && sub_i = subtask_count-1)))
                            {
                                if(quest_node[? "subtask_type"] == "simple_nav")
                                {
                                    player_quest_state_update(my_player, context, "setstate", "success");

                                    //speech_start("NAV AUTO-SUCCESS");
                                }
                                else if(quest_node[? "subtask_type"] == "simple_condition")
                                {
                                    player_quest_state_update(my_player, context, "setstate", "success");

                                    //speech_start("CONDITION AUTO-SUCCESS");
                                }
                                else if(quest_node[? "subtask_type"] == "item_pickup")
                                {
                                    var item_found = auto_pickup_quest_item(my_player, quest_node);
                                
                                    if(!item_found)
                                    {
                                        player_quest_state_update(my_player, context, "setstate", "success");
                                    
                                        /*
                                        my_console_log("ITEM PICKUP AUTO-SUCCESS");
                                    
                                        speech_instant("ITEM PICKUP AUTO-SUCCESS");
                                        */
                                    }
                                }
                            }
                        }
                    }
                
                    // DEMONSTRATION MODE
                    if(demonstration_mode
                    && (singleton_obj.step_count - demonstration_start) < (subtask_change_min_delay + irandom(subtask_change_delay_range)) )
                    {
                        break;
                    }
                
                
                    // NORMAL MODE
                    demonstration_mode = false;
                    grab_attention_mode = false;
            
                    if(!is_undefined(waypoint))
                    {
                        if(npc_destination != waypoint)
                        {
                            npc_final_waypoint = waypoint_id;
            
                            npc_destination_reached = false;
                            npc_destination_x = waypoint.x;
                            npc_destination_y = waypoint.y;
                            npc_destination = waypoint;
                        
                            grab_attention_done = false;
                            has_spoken = false;
                            has_autospoken = false;
                        }
                
                        if(waypoint != nearest_waypoint && npc_last_waypoint != npc_final_waypoint && !waypoint.dont_teleport_to_me)
                        {
                            var same_quest_tp = (string_pos(selected_subtask + "/", npc_last_waypoint) == 1);
                            var after_demo_tp = (point_distance(x,y, waypoint.x, waypoint.y) > 160 && demonstration_done);
                            var wp_tp_tagged = (instance_exists(npc_last_waypoint_obj) && npc_last_waypoint_obj.teleport_from_me) || waypoint.teleport_to_me;
                        
                            var can_tp = same_quest_tp || after_demo_tp || wp_tp_tagged;
                        
                            if(can_tp)
                            {
                                tut_guide_teleport(waypoint);
                            
                                /*
                                if(same_quest_tp)
                                {
                                    speech_instant("SAME QUEST");
                                }
                                if(after_demo_tp)
                                {
                                    speech_instant("AFTER DEMO");
                                }
                                if(wp_tp_to_me)
                                {
                                    speech_instant("WP TP TO ME");
                                }
                                */
                    
                                grab_attention_done = false;
                                demonstration_done = false;
                            
                            }
                        }
                    }
        
                    if(pl_dist > talk_stop_dist)
                    {
                        if(!has_autospoken || player_was_near)
                        {
                            has_spoken = false;
                        }
                
                        player_was_near = false;
                    }
                    else if(npc_destination_reached)
                    {
                        player_was_near = true;
                    }
            
                    if(npc_destination_reached && instance_exists(nearest_waypoint) && npc_final_waypoint == nearest_waypoint.waypoint_id)
                    {
                        if( (pl_dist < talk_start_dist
                            || (npc_final_waypoint == selected_subtask + "/failure" && failure_count >= failure_limit)
                            || ((nearest_waypoint.autospeak || npc_autospeak) && !has_autospoken) ))
                        {
                            if(!has_spoken && !speaking)
                            {
                                if(pl_dist < autospeak_dist || !(nearest_waypoint.autospeak || npc_autospeak))
                                {
                                    if(nearest_waypoint.grab_attention && !grab_attention_done)
                                    {
                                        grab_attention_mode = true;
                                        grab_attention_start = singleton_obj.step_count;
                                        npc_waypoint_y -= 32;
                                        npc_destination_y -= 32;
                                    }
                                    else
                                    {
                                        demonstration_done = false;
                                        if (!speech_start(main_quest_id + DB.quest_context_divider + waypoint_id, true, guided_guy))
                                        {
                                            demonstration_done = true;
                                        }
                                    
                                        if(nearest_waypoint.autospeak || npc_autospeak)
                                        {
                                            has_autospoken = true;
                                        }
                                    }
                                }
                            
                            
                                phase = 1;
                            }
                        }
                    }

                    break;
                }
        
                // speaking
                case 1:
                {
                    if(grab_attention_mode)
                    {
                        if((singleton_obj.step_count - grab_attention_start) < grab_attention_duration)
                        {
                            break;
                        }
                        else
                        {
                            grab_attention_done = true;
                            grab_attention_mode = false;
                        
                            if(instance_exists(nearest_waypoint))
                            {
                                npc_waypoint_y = nearest_waypoint.y;
                                npc_destination_y = nearest_waypoint.y;
                            }
                        
                            phase = 0;
                            break;
                        }
                    }

                    if(!speaking)
                    {
                        if(!speech_interrupted)
                        {
                            if(npc_final_waypoint != selected_subtask + "/failure"
                            && (failure_count < failure_limit
                                || (npc_final_waypoint == selected_subtask + "/success"
                                    || npc_final_waypoint == selected_subtask + "/success-taunt")))
                            {
                                if(demonstration_mode)
                                {
                                    demonstration_start = singleton_obj.step_count;
                                    demonstration_done = true;
                                }
                            
                                phase = 0;
                            }
                            else
                            {
                                if(string_pos(selected_subtask + "/", npc_last_waypoint) == 1)
                                {
                                    demonstration_mode = true;
                                    demonstration_start = singleton_obj.step_count;
                                    demonstration_done = false;
                                    phase = 2;
                                }
                                else
                                {
                                    phase = 0;
                                }
                            }
                        }
                
                        if(!has_spoken)
                        {
                            has_autospoken = false;
                        }
                    }

                    break;
                }
        
                // DEMONSTRATION MODE - show how to return and if too many failures, also how to success
                case 2:
                {
                    if((singleton_obj.step_count - demonstration_start) < (subtask_change_min_delay + irandom(subtask_change_delay_range)))
                    {
                        break;
                    }
            
                    var waypoint_id = selected_subtask + "/active";
                    var speech_mode = "";
            
                    if((failure_count >= failure_limit && npc_destination_reached && npc_final_waypoint == selected_subtask + "/active" && has_spoken)
                    || npc_final_waypoint == selected_subtask + "/success"
                    || npc_final_waypoint == selected_subtask + "/success-taunt")
                    {
                        waypoint_id = selected_subtask + "/success";
                        speech_mode = "-taunt";
                    }
            
                    var waypoint;
            
                    waypoint = group_find_member(group, waypoint_id+speech_mode);
                    if(is_undefined(waypoint))
                    {
                        waypoint = group_find_member(group, waypoint_id);
                    }
            
                    if(!is_undefined(waypoint))
                    {
                        if(npc_destination != waypoint)
                        {
                            npc_final_waypoint = waypoint.waypoint_id;
            
                            npc_destination_reached = false;
                            npc_destination_x = waypoint.x;
                            npc_destination_y = waypoint.y;
                            npc_destination = waypoint;
                            //last_phase0_wp_id_change = singleton_obj.step_count;
                    
                            grab_attention_done = false;
                            has_spoken = false;
                            has_autospoken = false;
                        }
                    
                        if(npc_last_waypoint != npc_final_waypoint && !waypoint.dont_teleport_to_me)
                        {
                            var wp_tp_tagged = (instance_exists(npc_last_waypoint_obj) && npc_last_waypoint_obj.teleport_from_me) || waypoint.teleport_to_me;
                        
                            var can_tp = wp_tp_tagged;
                        
                            if(can_tp)
                            {
                                tut_guide_teleport(waypoint);
                                /*
                                if(wp_tp_tagged)
                                {
                                    speech_instant("WP TP TAGGED");
                                }
                                */
                                /*
                                grab_attention_done = false;
                                demonstration_done = false;
                                */
                            }
                        }
                    }
                    else
                    {
                        demonstration_done = true;
                        phase = 0;
                        break;
                    }
            
                    if(npc_destination_reached)
                    {
                        if(waypoint.wait_for_player)
                        {
                             if(pl_dist > talk_start_dist)
                             {
                                break;
                             }
                        }
                
                        if(failure_count >= failure_limit && main_quest_state[? "selected_subtask"] == selected_subtask)
                        {
                            if(waypoint.grab_attention && !grab_attention_done)
                            {
                                grab_attention_mode = true;
                                grab_attention_start = singleton_obj.step_count;
                                npc_waypoint_y -= 32;
                                npc_destination_y -= 32;
                            }
                            else
                            {
                                speech_start(main_quest_id + DB.quest_context_divider + waypoint_id + speech_mode, true, guided_guy);
                            }
                            demonstration_done = true;
                            phase = 1;
                        }
                
                    }
        
                    break;
                }
            }
        }
    
        npc_guy2_step();
    
        if(npc_destination_reached)
        {
            // look at nearest guy
            if(instance_exists(guided_guy) && desired_aim_dist == 0 && !charging && !casting)
            {
                set_guy_facing((guided_guy.x - x) > 0);
            }
        }
    
        if(last_phase != phase)
        {
            my_console_log("PHASE " + string(last_phase) + " -> " + string(phase));
        }
        last_phase = phase;
    }
}
