/// @description player_quest_recheck(player, context)
/// @function player_quest_recheck
/// @param player
/// @param  context
function player_quest_recheck() {
    var player = argument[0];
    var context = argument[1];

    if(context == "")
    {
        return 0;
    }

    var tr_list, tr_i, tr_count, transition, tr_possible;
    var target_state, state_list, state_i, state_count, state, state_props;
    var cond_list, cond_i, cond_count, condition, tr_cond_str, cond_state, fulfilled_count;
    var effect_list, effect_i, effect_count, effect;
    var sub_i, subtasks_list, subtask_count, context_id, subtasks, subtask;
    var subtask_state, mandatory_subtask_chosen, subtask_chosen, mandatory_subtasks_progress, subtasks_done, subtasks_mandatory_todo, subtasks_todo;
    var subtasks_unskipped_todo, subtasks_mandatory_unskipped_todo, last_subtask;

    var quest_state = player.quest_states[? context];
    var quest_id = quest_state[? "quest_id"];
    var quest_node = DB.quest_nodes[? quest_id];
    var all_state_props = quest_node[? "state_properties"];
    var cur_reps = quest_state[? "state_reps"];
    var cond_states = quest_state[? "transition_condition_states"];
    var parent_context = quest_state[? "parent_context"];
    var parent_quest_id = quest_state[? "parent_quest_id"];
    var my_context_id = quest_state[? "context_id"];

    var checks_done = 0;


    // IF IS FIRST SUBTASK, AUTO START
    if(parent_context != "" && quest_state[? "current_state"] == "init")
    {   
        var parent_node = DB.quest_nodes[? parent_quest_id];
        var parent_state = player.quest_states[? parent_context];
        subtasks = parent_node[? "subtasks"];
        var my_subtask = subtasks[? my_context_id];
    
        // SUBTASK START UP
        if(parent_state[? "current_state"] != "init" && my_subtask[? "order_index"] == 1 && quest_state[? "current_state"] == "init") // <= parent_state[? "subtasks_progress"]
        {        
            player_quest_state_update(player, context, "setstate", "start");
        }
    }


    // SUBTASKS
    subtasks_list = quest_node[? "subtasks_list"];
    subtask_count = ds_list_size(subtasks_list);
    subtasks = quest_node[? "subtasks"];

    for(sub_i = 0; sub_i < subtask_count; sub_i++)
    {
        context_id = subtasks_list[| sub_i];
        checks_done += player_quest_recheck(player, context + DB.quest_context_divider + context_id);
    }


    // TRANSITIONS
    tr_list = quest_node[? "state_transitions"];
    tr_count = ds_list_size(tr_list);

    for(tr_i = 0; tr_i < tr_count; tr_i++)
    {
        checks_done++;
        transition = tr_list[| tr_i];
        tr_possible = false;
    
        target_state = transition[? "to_state"];
        state_props = all_state_props[? target_state];
    
        // MAX REPS LIMIT
        if(state_props[? "max_reps"] >= 0 && state_props[? "max_reps"] <= cur_reps[? target_state])
        {
            continue;
        }
    
        // FROM STATES
        state_list = transition[? "from_states"];
        state_count = ds_list_size(state_list);
    
        for(state_i = 0; state_i < state_count; state_i++)
        {
            state = state_list[| state_i];
            state_props = all_state_props[? state];
        
            if(quest_state[? "current_state"] == state
            || ((quest_state[? "current_state"] != "init" || target_state == "start")
                && (state == "any" 
                || (state == "nonsuccess" && quest_state[? "current_state"] != "success")
                || (state == "nonfailure" && quest_state[? "current_state"] != "failure") )))
            {
                tr_possible = true;
                break;
            }
        }
    
        if(tr_possible)
        {    
            // CONDITIONS
            cond_list = transition[? "conditions"];
            cond_count = ds_list_size(cond_list);
            fulfilled_count = 0;
        
            for(cond_i = 0; cond_i < cond_count; cond_i++)
            {
                condition = cond_list[| cond_i];
                tr_cond_str = string(tr_i) + " " + string(cond_i);
            
                // CONDITION: subtasks_success
                if(condition[? "type"] == "subtasks" && condition[? "verb"] == "success")
                {
                    subtask_chosen = "";
                    mandatory_subtask_chosen = "";
                    mandatory_subtasks_progress = 0;
                    subtasks_done = 0;
                    subtasks_mandatory_unskipped_todo = 0;
                    subtasks_mandatory_todo = 0;
                    subtasks_unskipped_todo = 0;
                    subtasks_todo = 0;
                
                    for(sub_i = 0; sub_i < subtask_count; sub_i++)
                    {
                        context_id = subtasks_list[| sub_i];
                        subtask_state = player.quest_states[? context + DB.quest_context_divider + context_id];
                        subtask = subtasks[? context_id];
                    
                        if(sub_i == subtask_count-1)
                        {
                            last_subtask = subtask;   
                        }
                    
                        if(subtask[? "order_index"] <= quest_state[? "subtasks_progress"])
                        {
                            if(subtask_state[? "current_state"] == "success")
                            {
                                subtasks_done++;
                                if(mandatory_subtasks_progress < subtask[? "order_index"])
                                {
                                    mandatory_subtasks_progress = subtask[? "order_index"];
                                }
                        
                                subtask_chosen = context_id;
                            
                                subtasks_unskipped_todo = 0;
                                subtasks_mandatory_unskipped_todo = 0;
                        
                                continue;
                            }
                            else
                            {
                                if(mandatory_subtask_chosen == "" && subtask_state[? "current_state"] != "init") // && subtask[? "order_index"] == quest_state[? "subtasks_progress"]
                                {
                                    if(subtask_chosen == "" || subtasks_unskipped_todo == 0)
                                    {
                                        subtask_chosen = context_id;
                                    }
                            
                                    if(subtask[? "mandatory"])
                                    {
                                        mandatory_subtask_chosen = context_id;
                                        if(mandatory_subtasks_progress < subtask[? "order_index"])
                                        {
                                            mandatory_subtasks_progress = subtask[? "order_index"];
                                        }
                                    }
                            
                                }
                        
                                subtasks_todo++;
                                subtasks_unskipped_todo++;
                        
                                if(subtask[? "mandatory"])
                                {
                                    subtasks_mandatory_todo++;
                                    subtasks_mandatory_unskipped_todo++;
                                }
                            }
                        }
                    }

                
                    // SAVE RESULT
                    if(mandatory_subtask_chosen != "")
                    {
                        quest_state[? "selected_subtask"] = mandatory_subtask_chosen;    
                    }
                    else if(subtask_chosen != "")
                    {
                        quest_state[? "selected_subtask"] = subtask_chosen;
                    }
           
                    cond_states[? tr_cond_str] = (subtasks_done == subtask_count);
                
                
                    quest_state[? "mandatory_subtasks_progress"] = mandatory_subtasks_progress;
                
                    // ENABLE NEXT SUBTASK
                    if(subtasks_mandatory_unskipped_todo == 0 && subtask_count > 0)
                    {
                        if((subtasks_done + subtasks_todo) < subtask_count)
                        {
                            quest_state[? "subtasks_progress"]++;
                        }
                        else
                        {
                            quest_state[? "subtasks_progress"] = min(subtask_count, last_subtask[? "order_index"]);
                        }
                    }
                }
                else
                {
                    // INIT
                    var parent_node = DB.quest_nodes[? parent_quest_id];
                    var parent_state = player.quest_states[? parent_context];
                    subtasks = parent_node[? "subtasks"];
                    var my_subtask = subtasks[? my_context_id];
                    var subtask_reached = parent_state[? "subtasks_progress"] >= my_subtask[? "order_index"];
                
                    // CONDITION: subtask_reached
                    if(condition[? "type"] == "subtask" && condition[? "verb"] == "reached")
                    {
                        cond_states[? tr_cond_str] = subtask_reached;
                    }
                    // CONDITION: zone_enter
                    else if(condition[? "type"] == "zone" && condition[? "verb"] == "enter")
                    {
                        var group = get_group("zones");
                        
                        if (instance_exists(group) && instance_exists(player.my_guy)) {
                            var zone = group_find_member(group, condition[? "zone_id"]);
                            
                            if (!is_undefined(zone) && instance_exists(zone)) {
                                var inside = ds_list_find_index(zone.inside_list, player.my_guy.id) != -1;
                        
                                cond_states[? tr_cond_str] = inside;
                            }
                        }
                    }
                    // CONDITION: channel_duration
                    else if(condition[? "type"] == "channel" && condition[? "verb"] == "duration")
                    {
                        cond_states[? tr_cond_str] = player.my_guy.channel_duration >= condition[? "duration"];
                    }
                    // CONDITION: has_tried_to_move
                    else if(condition[? "type"] == "has_tried_to" && condition[? "verb"] == "move")
                    {
                        var state = false;
                        if(instance_exists(player.my_guy))
                        {
                            state = player.my_guy.wanna_run;
                        }
                
                        cond_states[? tr_cond_str] = state;
                    }
                    // CONDITION: record_time_start_step
                    else if(condition[? "type"] == "record_time" && condition[? "verb"] == "start_step")
                    {
                        quest_state[? "start_step"] = singleton_obj.step_count;
                
                        cond_states[? tr_cond_str] = true;
                    }
                    // CONDITION: time_elapsed_from_start
                    else if(condition[? "type"] == "time_elapsed" && condition[? "verb"] == "from_start")
                    {
                        state = (singleton_obj.step_count - quest_state[? "start_step"]) >= quest_node[? "from_start"];
                
                        cond_states[? tr_cond_str] = state;
                    }
                    // CONDITION: trigger_displays
                    else if(condition[? "type"] == "trigger" && condition[? "verb"] == "displays")
                    {
                        if(instance_exists(player.my_guy) && subtask_reached)
                        {
                            trigger(place_controller_obj, quest_node[? "display_group"], my_guy);   
                        }
                
                        cond_states[? tr_cond_str] = true;
                    }
                    // CONDITION: trigger_spawners
                    else if(condition[? "type"] == "trigger" && condition[? "verb"] == "spawners")
                    {
                        if(instance_exists(player.my_guy) && subtask_reached)
                        {
                            var group_id = quest_node[? "spawner_group"];
                            var spawners = get_group(group_id);
                            var member_count = ds_list_size(spawners.members);
                            var m_i, spawner;
                        
                            for(m_i = 0; m_i < member_count; m_i++)
                            {
                                spawner = spawners.members[| m_i];
                            
                                with(player.my_guy)
                                {
                                    with(spawner)
                                    {
                                        event_perform(ev_collision, guy_obj);
                                    }
                                }
                            }
                        }
                
                        cond_states[? tr_cond_str] = true;
                    }
                }
            
                // FULFILLED
                cond_state = cond_states[? tr_cond_str];
            
                if(!is_undefined(cond_state) && cond_state)
                {
                    fulfilled_count++;
                }
            }
        
            // ON SUCCESS
            if(fulfilled_count == cond_count && quest_state[? "current_state"] != target_state)
            {
                // EFFECTS
                effect_list = transition[? "effects"];
                effect_count = ds_list_size(effect_list);
                fulfilled_count = 0;
            
                for(effect_i = 0; effect_i < effect_count; effect_i++)
                {
                    effect = effect_list[| effect_i];
                    
                    // EFFECT: trigger_displays
                    if(effect[? "type"] == "displays" && effect[? "verb"] == "trigger")
                    {
                        if(instance_exists(player.my_guy) && player != gamemode_obj.environment)
                        {
                            trigger(place_controller_obj, effect[? "display_group"], player.my_guy);
                        }
                    }
                    // EFFECT: trigger_spawners
                    else if(effect[? "type"] == "spawners" && effect[? "verb"] == "trigger")
                    {
                        if(instance_exists(player.my_guy))
                        {
                            var group_id = effect[? "spawner_group"];
                            var spawners = get_group(group_id);
                            var member_count = ds_list_size(spawners.members);
                            var m_i, spawner;
                        
                            for(m_i = 0; m_i < member_count; m_i++)
                            {
                                spawner = spawners.members[| m_i];
                            
                                with(player.my_guy)
                                {
                                    with(spawner)
                                    {
                                        event_perform(ev_collision, guy_obj);
                                    }
                                }
                            }
                        }
                    }
                }
            
                // QUEST STATE
                player_quest_state_update(player, context, "setstate", target_state);
            }
        }
    }

    return checks_done;
}
