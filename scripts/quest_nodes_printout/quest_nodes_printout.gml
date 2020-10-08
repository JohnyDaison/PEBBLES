/// @description quest_nodes_printout()
/// @function quest_nodes_printout
function quest_nodes_printout() {
	quest_count = ds_list_size(DB.quest_node_ids);

	for(i = 0; i < quest_count; i++)
	{
	    quest_id = DB.quest_node_ids[| i];
	    my_console_write(string(i) + " " + quest_id);
	}

	return quest_count;



}
