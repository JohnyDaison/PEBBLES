/// @function quest_create_subtask
/// @param  parent_quest_id
/// @param  subquest_type
/// @param  context_id
/// @param  name
/// @param  description
/// @param  order_index
/// @param  mandatory
function quest_create_subtask(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {

	var parent_quest_id = argument0;
	var subquest_type = argument1;
	var context_id = argument2;
	var name = argument3;
	var description = argument4;
	var order_index = argument5;
	var mandatory = argument6;

	var subquest_id = parent_quest_id + "_" + context_id;
	var node = noone;
	var transition, condition;

	if(subquest_type == "simple_condition")
	{
	    node = quest_node_create(subquest_id, name, description);
	    node[? "subtask_type"] = "simple_condition";
    
	    transition = quest_transition_create(subquest_id, "init", "start");
	    transition = quest_transition_create(subquest_id, "nonsuccess", "success");
     
	    quest_add_subtask(parent_quest_id, subquest_id, context_id, order_index, mandatory);
	}

	if(subquest_type == "simple_nav")
	{
	    node = quest_simple_nav_create(subquest_id, name, description, context_id);
	    node[? "guide_failure_limit"] = 2;
     
	    quest_add_subtask(parent_quest_id, subquest_id, context_id, order_index, mandatory);
	}

	if(subquest_type == "simple_nav_reached_start")
	{
	    node = quest_node_create(subquest_id, name, description);
	    node[? "subtask_type"] = "simple_nav_reached_start";
	    node[? "guide_failure_limit"] = 2;
    
	    transition = quest_transition_create(subquest_id, "init", "start");
	    condition = quest_add_condition(transition, "subtask", "reached");
	    transition = quest_transition_create(subquest_id, "nonsuccess", "success");
	    condition = quest_add_condition(transition, "zone", "enter", context_id + "/success");
    
	    quest_add_subtask(parent_quest_id, subquest_id, context_id, order_index, mandatory);
	}

	if(subquest_type == "item_pickup")
	{
	    node = quest_item_pickup_create(subquest_id, name, description, context_id);
     
	    quest_add_subtask(parent_quest_id, subquest_id, context_id, order_index, mandatory);
	}

	if(subquest_type == "simple_destroy_target")
	{
	    node = quest_node_create(subquest_id, name, description);
	    node[? "subtask_type"] = "simple_destroy_target";
	    node[? "destroy_target"] = all;
	    node[? "target_color"] = -1;
    
	    transition = quest_transition_create(subquest_id, "init", "start");
	    transition = quest_transition_create(subquest_id, "nonsuccess", "success");
	    quest_add_condition(transition, "object", "destroy");
     
	    quest_add_subtask(parent_quest_id, subquest_id, context_id, order_index, mandatory);
	}

	if(subquest_type == "use_ability")
	{
	    node = quest_node_create(subquest_id, name, description);
	    node[? "subtask_type"] = "use_ability";
	    node[? "target_color"] = -1;
	    //node[? "target_amount"] = 1;

	    transition = quest_transition_create(subquest_id, "init", "start");
	    //condition = quest_add_condition(transition, "subtask", "order");

	    transition = quest_transition_create(subquest_id, "nonsuccess", "success");
	    quest_add_condition(transition, "ability", "use");
     
	    quest_add_subtask(parent_quest_id, subquest_id, context_id, order_index, mandatory);
	}

	if(subquest_type == "simple_time_delay")
	{
	    node = quest_node_create(subquest_id, name, description);
	    node[? "subtask_type"] = "simple_time_delay";
	    node[? "from_start"] = 1;
    
	    transition = quest_transition_create(subquest_id, "init", "start");
	    quest_add_condition(transition, "subtask", "reached");
	    quest_add_condition(transition, "record_time", "start_step");
	    transition = quest_transition_create(subquest_id, "nonsuccess", "success");
	    quest_add_condition(transition, "time_elapsed", "from_start");
     
	    quest_add_subtask(parent_quest_id, subquest_id, context_id, order_index, mandatory);
	}

	return node;


}
