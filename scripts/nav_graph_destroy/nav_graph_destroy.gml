/// @description nav_graph_destroy()
/// @function nav_graph_destroy
function nav_graph_destroy() {

	ds_list_destroy(nav_graph_node_ids);
	ds_map_destroy(nav_graph_nodes);

	count = ds_list_size(nav_graph_edges);

	for(i = count-1; i >= 0; i--)
	{
	    edge = nav_graph_edges[| i];
	    ds_map_destroy(edge);
	}
	ds_list_destroy(nav_graph_edges);



}
