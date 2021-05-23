if(!in_group && !moving)
{
    if(waypoint_id == "" && instance_exists(place_controller_obj) && place_controller_obj.auto_init_waypoints)
    {
        waypoint_id = "wp"+string(id);
        if(instance_place(x,y, guy_spawner_obj))
        {
            spawn_point = true;
            airborne = true;
        }
        var jump_pad = instance_place(x,y, universal_pad_obj);
        if(place_meeting(x,y, jump_pad_obj)
        || (instance_exists(jump_pad) && jump_pad.pad_color == g_cyan))
        {
            jump_pad_point = true;
            // this doesn't work for universal_pad_obj, because they aren't g_cyan in the first step
        }
    }
    
    if(waypoint_id != "")
    {
        group_auto_group("waypoints", id, waypoint_id);
        in_group = true;
    }
}

if(!dragged && auto_adjust && singleton_obj.step_count mod 5 == 3)
{
    var is_moving = false;
    
    if(!airborne && !wallclimb_point && !walljump_point && !jump_pad_point && !spawn_point)
    {
        var original_chunk_y = y div chunkgrid_obj.chunk_size;
        var current_chunk_y;
        
        while(place_meeting(x, y, terrain_obj))
        {
            if(my_chunklist != noone)
            {
                chunk_deregister(chunkgrid_obj, id);
            }
            
            y -= 32;
            is_moving = true;
            
            if(y < 0)
            {
                instance_destroy();
                
                regenerate_nav_graph();
                
                exit;
            }
        }
        
        while(!place_meeting(x, y+32, terrain_obj) && !place_meeting(x, y+32, platform_obj))
        {
            if(my_chunklist != noone)
            {
                chunk_deregister(chunkgrid_obj, id);
            }
            
            y += 32;
            is_moving = true;
            
            current_chunk_y = y div chunkgrid_obj.chunk_size;
            
            if(current_chunk_y != original_chunk_y)
            {
                break;
            }
            
            if(y > room_height)
            {
                instance_destroy();
                
                regenerate_nav_graph();
                
                exit;
            }
        }
        
        if(!moving && is_moving)
        {
            moving = true;
            group_remove_member(get_group("waypoints"), id);
            in_group = false;
            
            regenerate_nav_graph();   
        }
        
        if(moving && !is_moving)
        {
            moving = false;
            group_auto_group("waypoints", id, waypoint_id);
            in_group = true;
            if(!regenerate_nav_graph())
            {
                // TODO: the edge costs should be updated here and edges deleted if (dist >= DB.npc_waypoint_disconnect_dist)
            }
        }
        
        if(my_chunklist == noone)
        {
            var done_for = false;
            var min_margin = 32;
            var near_wp = collision_rectangle(x - min_margin, y - min_margin,
                                              x + min_margin, y + min_margin, npc_waypoint_obj, false, true);
            if(near_wp)
            {
                done_for = true;        
            }
            else
            {
                chunk_register(chunkgrid_obj, id);
            }
            
            if(done_for)
            {
                instance_destroy();
                regenerate_nav_graph();
                exit;
            }
        }        
    }
    
    if(side_attached)
    {
        var tries = 3;
        var ter, x_offset = 0;
    
        while(side_terrain == noone && tries > 0)
        {
            if(tries == 2)
            {
                x_offset = -16;   
            }
            else if(tries == 1)
            {
                x_offset = 16;   
            }
        
            ter = instance_place(x+x_offset, y, terrain_obj);
        
            if(instance_exists(ter))
            {
                side_terrain = ter;
            }
        
            tries--;
        }
    
        if(!instance_exists(side_terrain) || point_distance(x,y, side_terrain.x+15, side_terrain.y+15) > 56)
        {
            instance_destroy();
                
            regenerate_nav_graph();
                
            exit;   
        }
    }
}




// debug
if(DB.console_mode == "debug")
{
    invisible = false;
    visible = !invisible;
    /*
    if(mouse_check_button_pressed(mb_left)
    && abs(cursor_obj.room_x - x) < 20
    && abs(cursor_obj.room_y - y) < 20)
    {
        with(basic_bot)
        {
            if(is_general_npc)
            {
                npc_final_waypoint = other.waypoint_id;
            
                npc_destination_reached = false;
                npc_destination_x = other.x;
                npc_destination_y = other.y;
                npc_destination = other;
            
                speech_instant("DEST " + other.waypoint_id);
            }
        }
    }
    */
    
    var cursor_grid_x = (cursor_obj.room_x div 16);
    var cursor_grid_y = (cursor_obj.room_y div 32);
    var grid_x = (x div 16);
    var grid_y = (y div 32);
        
    if(mouse_check_button_pressed(mb_left) && cursor_grid_x == grid_x && cursor_grid_y == grid_y)
    {
        dragged = !dragged;
    }
    /*
    if(!mouse_check_button(mb_left))
    {
        dragged = false;
    }
    */
    
    if(dragged)
    {
        x = cursor_grid_x * 16;
        y = cursor_grid_y * 32;
    }
}
else
{
    invisible = true;
    visible = !invisible;   
}