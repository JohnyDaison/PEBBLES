function guide_quick_movement(argument0) {
	if(my_color != g_green)
	{
	    set_my_color(g_green);
	}

	damage = 0;
	npc_autospeak = true;
	desired_aim_dir = 0;
	desired_aim_dist = 0;
	wanna_cast = false;

	var near_player_guy = argument0;
	var pl_dist = 0;
	var player = noone;
	if(instance_exists(near_player_guy))
	{
	    if(near_player_guy.is_npc)
	    {
	        with(player_guy)
	        {
	            near_player_guy = id;
	        }
	    }
    
	    if(!near_player_guy.is_npc)
	    {
	        pl_dist = point_distance(x,y, near_player_guy.x, near_player_guy.y);
	        player = near_player_guy.my_player;
	    }
	}

	if(instance_exists(player))
	{
	    var main_quest_id = "quick_tutorial_movement";
	    var main_context = "quick_tut_level1";
	    var main_quest_state = player_quest_state_find(player, main_quest_id, main_context, "main");
    
	    if(!main_quest_state)
	    {
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
	    if(selected_subtask != last_selected_subtask || subtask_current_state != last_subtask_state)
	    {
	        if(last_selected_subtask == next_selected_subtask && last_subtask_state == next_subtask_state) // && !is_undefined(waypoint)
	        {
	            next_selected_subtask = selected_subtask;
	            next_subtask_state = subtask_current_state;
	            last_subtask_change = singleton_obj.step_count;
	        }
	    }

	    if(last_selected_subtask != next_selected_subtask || last_subtask_state != next_subtask_state)
	    {
	        if((singleton_obj.step_count - last_subtask_change) > (subtask_change_min_delay + irandom(subtask_change_delay_range)))
	        {  
	            last_selected_subtask = next_selected_subtask;
	            last_subtask_state = next_subtask_state;
	        }
        
	        if(last_selected_subtask != "" && (last_selected_subtask != next_selected_subtask || next_subtask_state == "success")
	        && (singleton_obj.step_count - last_subtask_change) > (subtask_change_fast_min_delay + irandom(subtask_change_delay_range)))
	        {
	            last_selected_subtask = next_selected_subtask;
	            last_subtask_state = next_subtask_state;
	            demonstration_mode = false;
	        }

	        selected_subtask = last_selected_subtask;
	        subtask_state = player_quest_state_find(player, "",  main_context + DB.quest_context_divider + selected_subtask, "");
	        subtask_current_state = last_subtask_state;
	    }
    
    
	    // TASKS HANDLING
	    if(demonstration_mode)
	    {
        
	        if(npc_destination_reached && has_spoken)
	        {
	            if(selected_subtask == "wall_jump")
	            {
	                npc_wallhold_time = 45;
	            }
	        }
	    }
    
	    // PHASES
	    waypoint_id = selected_subtask + "/" + subtask_current_state;
	    waypoint = group_find_member(group, waypoint_id);
    
	    var cur_reps = subtask_state[? "state_reps"];
	    var failure_count = cur_reps[? "failure"];
	    //var failure_limit = subtask_state[? "guide_failure_limit"];
	    var failure_limit = 0;
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
	            if(demonstration_mode && (singleton_obj.step_count - demonstration_start) < (subtask_change_min_delay + irandom(subtask_change_delay_range)))
	            {
	                break;
	            }
            
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
                
	                if(waypoint != nearest_waypoint && npc_last_waypoint != npc_final_waypoint && string_pos(selected_subtask + "/", npc_last_waypoint) == 1)
	                {
	                    effect_create_above(ef_firework, x,y, 1, DB.colormap[? g_blue]);
	                    facing_right = (waypoint.x - x) > 0;
	                    x = waypoint.x;
	                    y = waypoint.y;
	                    effect_create_above(ef_firework, x,y, 1, DB.colormap[? g_blue]);
	                    my_sound_play(tp_sound);
	                    has_tped = true;
                    
	                    grab_attention_done = false;
	                    has_spoken = false;
	                    has_autospoken = false;
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
	                                speech_start(main_quest_id + DB.quest_context_divider + waypoint_id, true, near_player_guy);
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
	                    npc_waypoint_y = nearest_waypoint.y;
	                    npc_destination_y = nearest_waypoint.y;
	                    phase = 0;
	                    break;
	                }
	            }

	            if(!speaking)
	            {
	                if(npc_final_waypoint != selected_subtask + "/failure"
	                && (failure_count < failure_limit
	                    || (npc_final_waypoint == selected_subtask + "/success"
	                        || npc_final_waypoint == selected_subtask + "/success-taunt")))
	                {
	                    if(demonstration_mode)
	                    {
	                        demonstration_start = singleton_obj.step_count;
	                    }
                    
	                    phase = 0;
	                }
	                else
	                {
	                    demonstration_mode = true;
	                    demonstration_start = singleton_obj.step_count;
                    
	                    phase = 2;
	                }
                
	                if(!has_spoken)
	                {
	                    has_autospoken = false;   
	                }
	            }

	            break;
	        }
        
	        // show how to return and if too many failures, also how to success
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
	            }
	            else
	            {
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
	                        speech_start(main_quest_id + DB.quest_context_divider + waypoint_id + speech_mode, true, near_player_guy);
	                    }
                    
	                    phase = 1;
	                }
                
	            }
        
	            break;
	        }
	    }
	}



}
