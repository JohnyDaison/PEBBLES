/// @description condition_event_script(event, source, context_str, params)
/// @function condition_event_script
/// @param event
/// @param  source
/// @param  context_str
/// @param  params
function condition_event_script(argument0, argument1, argument2, argument3) {
    var event = argument0;
    var source = argument1;
    var context_str = argument2;
    var params = argument3;

    var root_context = "", context = "", tr_cond_str, tr_index, cond_index;
    var quest_state, quest_node, quest_id, tr_states;
    var transitions, transition, conditions, condition;

    var event_valid = false;
    var state_changed = false;

    var div_pos = string_pos("|", context_str);
    context = string_copy(context_str, 1, div_pos-1);
    tr_cond_str = string_delete(context_str, 1, div_pos);

    var space_pos = string_pos(" ", tr_cond_str);
    tr_index = real(string_copy(tr_cond_str, 1, space_pos-1))
    cond_index = real(string_delete(tr_cond_str, 1, space_pos));

    quest_state = id.quest_states[? context];
    quest_id = quest_state[? "quest_id"];
    quest_node = DB.quest_nodes[? quest_id];
    var orig_current_state = quest_state[? "current_state"];

    transitions = quest_node[? "state_transitions"];
    transition = transitions[| tr_index];
    conditions = transition[? "conditions"];
    condition = conditions[| cond_index];

    root_context = quest_state[? "root_context"];
    tr_states = quest_state[? "transition_condition_states"];

    var who_player = noone;

    if(!is_undefined(params) && ds_exists(params, ds_type_map) && !is_undefined(params[? "who"]) && instance_exists(params[? "who"]))
    {
        who_player = params[? "who"].my_player;   
    }

    switch(event)
    {

        // ZONE ENTER
        case "zone_enter":
        {
            var zone_id = get_group_key(source, get_group("zones"));
    
            if(who_player == id && condition[? "zone_id"] == zone_id)
            {
                event_valid = true;
            }
    
            break;
        }
    
        // GATE ZONE CLOSE
        case "gatezone_close":
        {
            var zone_id = get_group_key(source, get_group("zones"));
    
            if(condition[? "zone_id"] == zone_id)
            {
                event_valid = true;
            }
    
            break;
        }
    
        // GATE ZONE OPEN
        case "gatezone_open":
        {
            var zone_id = get_group_key(source, get_group("zones"));
    
            if(condition[? "zone_id"] == zone_id)
            {
                event_valid = true;
            }
    
            break;
        }

        // ITEM PICKUP
        case "item_pickup":
        {
            var item_index = source.object_index;
            var item_color = source.my_color;
    
            if(who_player == id
            && (quest_node[? "target_item"] == all || quest_node[? "target_item"] == item_index)
            && (quest_node[? "target_color"] == -1 || quest_node[? "target_color"] == item_color))
            {
                event_valid = true;
            }
    
            break;
        }

        // ORB ORBITS
        case "orb_orbits":
        {
            var orbit_anchor = source.orbit_anchor;
            var orb_color = source.my_color;
    
            if(who_player == id
            && (condition[? "orb_color"] == -1 || condition[? "orb_color"] == orb_color)
            && (condition[? "orbit_anchor"] == all || object_is_child(orbit_anchor, condition[? "orbit_anchor"])) )
            {
                event_valid = true;
            }
    
            break;
        }

        // MY BODY COLOR CHANGE
        case "my_body_color_change":
        {
            if(source.my_player == id
            && source.my_player.my_guy == source
            && (( condition[? "body_color"] == "non_dark" && source.my_color > g_dark ) 
                || condition[? "body_color"] == source.my_color ))
            {
                event_valid = true;
            }
    
            break;
        }
    
        // SIMPLE DESTROY TARGET
        case "object_destroy":
        {
            var obj_index = source.object_index;
            var obj_color = source.my_color;
    
            if(who_player == id
            && (quest_node[? "destroy_target"] == all || quest_node[? "destroy_target"] == obj_index)
            && (quest_node[? "target_color"] == -1 || quest_node[? "target_color"] == obj_color) )
            {
                event_valid = true;
            }
    
            break;
        }
    
        // VORTEX KNOCKDOWN
        case "vortex_knockdown":
        {
            var obj_index = source.object_index;
            var obj_color = source.my_color;
    
            if(who_player == id
            && (quest_node[? "knockdown_target"] == all || quest_node[? "knockdown_target"] == obj_index)
            && (quest_node[? "target_color"] == -1 || quest_node[? "target_color"] == obj_color) )
            {
                event_valid = true;
            }
    
            break;
        }
    
        // USE ABILITY
        case "ability_use":
        {
            var abi_color = params[? "abi_color"];
    
            if(who_player == id
            && (quest_node[? "target_color"] == -1 || quest_node[? "target_color"] == abi_color) )
            {
                event_valid = true;
            }
    
            break;
        }
    
        // PRESS PIEZOPLATE
        case "piezoplate_press":
        {
            var color = params[? "color"];
            var pl_num = -1;
            if(instance_exists(who_player))
            {
                pl_num = who_player.number;
            }
    
            if((quest_node[? "target_player"] == -1 || quest_node[? "target_player"] == pl_num)
            && (quest_node[? "target_color"] == -1 || quest_node[? "target_color"] == color) )
            {
                event_valid = true;
            }
    
            break;
        }

    }

    if(event_valid)
    {
        tr_states[? tr_cond_str] = true;
        player_quest_recheck(id, root_context);
    
        if(orig_current_state != quest_state[? "current_state"])
        {
            player_quest_state_printout(id, context, 2, 1);
            state_changed = true;
        }
    }

    return state_changed;
}
