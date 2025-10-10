event_inherited();

// debug
if (DB.console_mode == CONSOLE_MODE.DEBUG)
{
    if (is_general_npc)
    {
        my_draw_set_font(label_font);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    
        if (instance_exists(next_body_terrain))
        {
            draw_set_colour(c_green);
            my_draw_text(next_body_terrain.x, next_body_terrain.y, "NB");
        }
    
        if (instance_exists(blocking_terrain))
        {
            draw_set_colour(c_red);
            my_draw_text(blocking_terrain.x, blocking_terrain.y, "BL");
        }
    
        if (instance_exists(next_takeoff_terrain))
        {
            draw_set_colour(c_blue);
            my_draw_text(next_takeoff_terrain.x, next_takeoff_terrain.y, "NT");
        }
    
        if (instance_exists(landing_terrain))
        {
            draw_set_colour(c_yellow);
            my_draw_text(landing_terrain.x, landing_terrain.y, "LA");
        }
    
        my_draw_set_font(infodisplay_font);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
    
        if (instance_exists(nearest_waypoint))
        {
            draw_set_colour(c_red);
            my_draw_text(nearest_waypoint.x, nearest_waypoint.y - 32, "NW");
        }
    
        if (instance_exists(npc_last_waypoint_obj))
        {
            draw_set_colour(c_yellow);
            my_draw_text(npc_last_waypoint_obj.x, npc_last_waypoint_obj.y - 32, "LW");
        }
    
        draw_set_colour(c_orange);
        var target, att_count = ds_list_size(attack_targets);
        for (var i = 0; i < att_count; i++)
        {
            target = attack_targets[| i];
            if (instance_exists(target))
            {
                draw_line_width(x,y, target.x, target.y, 3);
            }
        }
        
        if (instance_exists(attack_target))
        {
            draw_set_colour(c_red);
            my_draw_text(attack_target.x, attack_target.y - 32, "AT");
        }
    
        if (instance_exists(move_target))
        {
            draw_set_colour(c_yellow);
            my_draw_text(move_target.x, move_target.y - 32, "MT");
        }
        
        if (instance_exists(npc_destination))
        {
            draw_set_colour(c_fuchsia);
            my_draw_text(npc_destination.x, npc_destination.y - 32, "DEST");
        }
        
    
        var path_length = ds_list_size(current_path);
        var x1, y1, x2, y2, wp1 = noone, wp2 = noone;
        var group = get_group("waypoints");
    
        draw_set_colour(c_white);
    
        for (var i = 0; i < path_length; i++)
        {
            wp1 = wp2;
            wp2 = group_find_member(group, current_path[| i]);
            
            if (!is_undefined(wp1) && !is_undefined(wp2))
            {
                x2 = wp2.x;
                y2 = wp2.y;
                
                if (i == 0)
                {
                    x1 = x;
                    y1 = y;
                }
                else
                {
                    x1 = wp1.x;
                    y1 = wp1.y;
                }
                
                draw_line_width(x1,y1, x2,y2, 3);
            }
        }
        
    
        if (cannot_see_waypoint)
        {
            draw_set_colour(c_red);
        }
        else
        {
            draw_set_colour(c_green);
        }
        
        draw_line_width(x,y, npc_waypoint_x, npc_waypoint_y, 3);
        
        draw_set_colour(c_fuchsia);
        draw_line_width(x,y, npc_destination_x, npc_destination_y, 3);
    }
    
    if (bot_type == "volleyball_bot" && instance_exists(place_controller_obj.da_ball))
    {
        var path_length = ds_list_size(predicted_ball_path);
        var x1, y1, x2, y2, point1 = noone, point2 = noone;
    
        draw_set_colour(tint);
    
        for (var i = 0; i < path_length; i++)
        {
               point1 = point2;
               point2 = predicted_ball_path[| i];
           
               x2 = point2[? "x"];
               y2 = point2[? "y"];
           
               if (i == 0)
               {
                   x1 = place_controller_obj.da_ball.x;
                   y1 = place_controller_obj.da_ball.y;
               }
               else
               {
                   x1 = point1[? "x"];
                   y1 = point1[? "y"];
               }
           
               draw_line_width(x1,y1, x2,y2, 3);
        }
    }
}