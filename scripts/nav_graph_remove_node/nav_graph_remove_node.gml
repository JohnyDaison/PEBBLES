/// @description nav_graph_remove_node(string_id)
/// @function nav_graph_remove_node
/// @param string_id
function nav_graph_remove_node(argument0) {
	var string_id = argument0;

	if(!nav_graph_exists)
	{
	    return false;   
	}

	var index = ds_list_find_index(nav_graph_node_ids, string_id);
	var count = ds_list_size(nav_graph_edges);
	var i, edge;

	if(index != -1)
	{
	    for(i = count - 1; i >= 0; i--)
	    {
	        edge = nav_graph_edges[| i];
        
	        if(edge[? "from"] == string_id || edge[? "to"] == string_id)
	        {
	            ds_map_destroy(edge);
	            ds_list_delete(nav_graph_edges, i);
	        }   
	    }

	    ds_list_delete(nav_graph_node_ids, index);
	    ds_map_delete(nav_graph_nodes, string_id)
    
	    return true;
	}

	return false;



}
