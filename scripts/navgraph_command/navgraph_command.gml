function navgraph_command() {
    with(place_controller_obj)
    {
        if(!nav_graph_exists)
        {
            nav_graph_create();

            auto_init_waypoints = true;
            auto_generate_nav_graph = true;
        }
        
        generate_nav_graph = true;
        alarm[2] = 2;
    }
}
