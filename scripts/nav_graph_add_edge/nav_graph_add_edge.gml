/// @description nav_graph_add_edge(from, to, type, cost, [nav_cost])
/// @function nav_graph_add_edge
/// @param from
/// @param to
/// @param type
/// @param cost
/// @param [nav_cost]
function nav_graph_add_edge() {
	var from = argument[0];
	var to = argument[1];
	var type = argument[2];
	var cost = argument[3];
	var nav_cost = cost;
	if(argument_count > 4)
	{
	    nav_cost = argument[4];
	}

	if(ds_list_find_index(nav_graph_node_ids, from) != -1
	&& ds_list_find_index(nav_graph_node_ids, to) != -1)
	{
	    var edge = ds_map_create();
    
	    edge[? "from"] = from;
	    edge[? "to"] = to;
	    edge[? "type"] = type;
	    edge[? "cost"] = cost;
	    edge[? "nav_cost"] = nav_cost;
    
	    ds_list_add(nav_graph_edges, edge);

	    return true;
	}

	return false;



}
