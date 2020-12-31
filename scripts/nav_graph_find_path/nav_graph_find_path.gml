function nav_graph_find_path(start_node, end_node) {
	var path = ds_list_create();
	var edge_length_coef = DB.npc_waypoint_edge_length_coef;
	var debug_output = false;

	if(is_undefined(start_node) || is_undefined(end_node))
	{
	    my_console_log("NO PATH - start or end node undefined");
	    return path;
	}

	with(place_controller_obj)
	{
	    if(nav_graph_exists && nav_graph_enabled)
	    {
	        var open_nodes = ds_list_create();
	        var closed_nodes = ds_list_create();
	        var node_path_cost = ds_map_create();
	        var full_path_cost = ds_map_create();
	        var come_from = ds_map_create();
    
	        var group = get_group("waypoints");
	        var start_obj = group_find_member(group, start_node);
	        var end_obj = group_find_member(group, end_node);
        
	        //var total_node_count = ds_list_size(nav_graph_node_ids);
	        var total_edge_count = ds_list_size(nav_graph_edges);
        
	        var current_node = start_node;
	        var from_obj, to_node, to_obj;
	        var node_i, node, min_cost, cost, edge_i, edge, geo_dist_to_end, node_cost;
	        var done = false;
        
	        node_path_cost[? start_node] = 0;
        
	        if(is_undefined(start_obj) || is_undefined(end_obj))
	        {
	            my_console_log("NO PATH - start or end obj undefined");
	            done = true;
	        }
	        else
	        {
	            full_path_cost[? start_node] = round(point_distance(start_obj.x, start_obj.y, end_obj.x, end_obj.y) / edge_length_coef);
	            ds_list_add(open_nodes, start_node);
	        }
       
	        if(debug_output)
	        {
	            console_divider_level("=", 3);
                my_console_write("A STAR");
                console_divider_level("=", 3);
	        }
        
	        while(!done)
	        {
	            var open_node_count = ds_list_size(open_nodes);
	            min_cost = -1;
            
	            for(node_i = 0; node_i < open_node_count; node_i++)
	            {
	                node = open_nodes[| node_i];
                
	                cost = full_path_cost[? node];
                
	                if(min_cost == -1 || cost < min_cost)
	                {
	                    current_node = node;
	                    min_cost = cost;
	                }
	            }
            
	            if(debug_output)
	            {
	                my_console_write("current: " + current_node + " " + string(node_path_cost[? current_node]) + " " + string(full_path_cost[? current_node]));
	            }
            
	            if(current_node == end_node)
	            {
	                done = true;
	                break;
	            }
            
	            ds_list_delete(open_nodes, ds_list_find_index(open_nodes, current_node));
	            ds_list_add(closed_nodes, current_node);
            
	            from_obj = group_find_member(group, current_node);
            
	            if(!is_undefined(from_obj))
	            {
	                for(edge_i = 0; edge_i < total_edge_count; edge_i++)
	                {
	                    edge = nav_graph_edges[| edge_i];
                    
	                    if(edge[? "from"] == current_node)
	                    {
	                        to_node = edge[? "to"];
                        
	                        if(ds_list_find_index(closed_nodes, to_node) != -1)
	                        {
	                            continue;
	                        }
                        
	                        if(ds_list_find_index(open_nodes, to_node) == -1)
	                        {
	                            ds_list_add(open_nodes, to_node);
	                        }

                                                
	                        to_obj = group_find_member(group, to_node);
                        
	                        geo_dist_to_end = 10000;
	                        node_cost = node_path_cost[? current_node] + edge[? "cost"];
                        
	                        if(!is_undefined(node_path_cost[? current_node]) && node_cost >= node_path_cost[? to_node])
	                        {
	                            continue;
	                        }
                        
	                        if(!is_undefined(to_obj))
	                        {
	                            geo_dist_to_end = round(point_distance(to_obj.x, to_obj.y, end_obj.x, end_obj.y) / edge_length_coef);
	                        }
                        
	                        come_from[? to_node] = current_node;
	                        node_path_cost[? to_node] = node_cost;
	                        full_path_cost[? to_node] = node_path_cost[? to_node] + geo_dist_to_end;
	                    }
	                }
	            }
            
	            if(ds_list_size(open_nodes) == 0)
	            {
	                //my_console_log("OUT OF NODES - " + string(other.name));
	                done = true;
	            }
	        }
        
	        if(done && current_node == end_node)
	        {
	            while(current_node != start_node)
	            {
	                ds_list_insert(path, 0, current_node);
	                current_node = come_from[? current_node];
	            }
	        }
        
	        ds_list_destroy(open_nodes);
	        ds_list_destroy(closed_nodes);
	        ds_map_destroy(node_path_cost);
	        ds_map_destroy(full_path_cost);
	        ds_map_destroy(come_from);
	    }
	}

	return path;
}
