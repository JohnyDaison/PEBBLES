/// @description nav_graph_add_node(string_id, value)
/// @function nav_graph_add_node
/// @param string_id
/// @param  value
function nav_graph_add_node(argument0, argument1) {
	var string_id = argument0;
	var value = argument1;

	if(ds_list_find_index(nav_graph_node_ids, string_id) == -1)
	{

	    ds_list_add(nav_graph_node_ids, string_id);
	    nav_graph_nodes[? string_id] = value;
    
	    return true;
	}

	return false;



}
