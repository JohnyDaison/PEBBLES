function nav_graph_clear() {
    ds_list_clear(nav_graph_node_ids);
    ds_map_clear(nav_graph_nodes);

    var count = ds_list_size(nav_graph_edges);

    for(var i = count-1; i >= 0; i--)
    {
        var edge = nav_graph_edges[| i];
        ds_map_destroy(edge);
    }
    ds_list_clear(nav_graph_edges);
}
