/// @description DEBUG NAV GRAPH
if(DB.console_mode == CONSOLE_MODE.DEBUG)
{
    if(nav_graph_exists && nav_graph_enabled)
    {
        var total_edge_count = ds_list_size(nav_graph_edges);
        var wp_group = get_group("waypoints");
        var edge_i, edge, from_wp, to_wp;
        
        //draw_set_color(c_aqua);
        //draw_set_alpha(0.6);
        
        for(edge_i = 0; edge_i < total_edge_count; edge_i++)
        {
            edge = nav_graph_edges[| edge_i];
            
            from_wp = group_find_member(wp_group, edge[? "from"]);
            to_wp = group_find_member(wp_group, edge[? "to"]);
            
            if(is_undefined(from_wp) || is_undefined(to_wp))
            {
                continue;
            }
            
            var alpha = 0.3 * (point_distance(from_wp.x, from_wp.y, to_wp.x, to_wp.y)/DB.npc_waypoint_edge_length_coef) / edge[? "nav_cost"];
            var color;
            if(edge[? "cost"] == edge[? "nav_cost"])
            {
                color = c_aqua;
            }
            else
            {
                color = c_yellow;
            }
            
            draw_set_alpha(alpha);
            draw_set_color(color);
                    
            draw_line(from_wp.x, from_wp.y - 32, to_wp.x, to_wp.y);
        }
    }
}
