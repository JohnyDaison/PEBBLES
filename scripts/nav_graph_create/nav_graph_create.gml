function nav_graph_create() {
    nav_graph_exists = true;
    nav_graph_enabled = true;

    nav_graph_node_ids = ds_list_create();
    nav_graph_nodes = ds_map_create();
    nav_graph_edges = ds_list_create();
}
