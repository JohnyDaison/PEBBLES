/// @description quests_destroy()
/// @function quests_destroy
function quests_destroy() {
	var i, count, quest_id;

	count = ds_list_size(DB.quest_node_ids);

	for(i = count - 1; i >= 0; i--)
	{
	    quest_id = DB.quest_node_ids[| i];
	    quest_node_destroy(quest_id);
	}

	ds_list_destroy(DB.quest_states);
	ds_map_destroy(DB.quest_nodes);
	ds_list_destroy(DB.quest_node_ids);



}
