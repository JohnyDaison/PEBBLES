/// @description terrain_move(ter, to_x, to_y);
/// @function terrain_move
/// @param ter
/// @param  to_x
/// @param  to_y
function terrain_move(argument0, argument1, argument2) {
	var ter = argument0;
	var to_x = argument1;
	var to_y = argument2;

	if(!instance_exists(ter))
	{
	    return false;
	}

	var x_diff = to_x - ter.x;
	var y_diff = to_y - ter.y;

	with(ter)
	{
	    x += x_diff;
	    y += y_diff;
    
	    regenerate_nav_graph(2, false);
    
	    if(object_index == wall_obj)
	    {
	        for(i=0; i < 4; i++)
	        {
	            wall = near_walls[? i];
	            if(instance_exists(wall))
	            {
	                with(wall)
	                {
	                    alarm[0] = 2;
	                }
	            }
	        }

	        alarm[0]=1;
	    }
    
	    with(structure_obj)
	    {
	        if(my_block == other.id)
	        {
	            x += x_diff;
	            y += y_diff;
            
	            with(structure_obj)
	            {
	                if(my_struct == other.id)
	                {
	                    x += x_diff;
	                    y += y_diff;
	                }
	            }
	        }
	    }
	    with(energy_burst_obj)
	    {
	        if(my_guy == other.id)
	        {
	            x += x_diff;
	            y += y_diff;
	            event_perform(ev_alarm, 1);
	        }
	    }
    
	    with(phys_body_obj)
	    {
	        if(object_is_child(ter, supported_terrain))
	        {
	            var body = id, do_move = false, undo_move = false;
	            var was_touching = false, is_colliding = false;
        
	            with(ter)
	            {
	                was_touching = collision_rectangle(bbox_left-1 -x_diff, bbox_top-1 -y_diff, bbox_right+1 -x_diff, bbox_bottom+1-y_diff, body, false, false);
            
	                with(body)
	                {
	                    is_colliding = place_meeting(x, y, ter);
                
	                    if(((was_touching && !airborne) || is_colliding) && !place_meeting(x + x_diff, y + y_diff, supported_terrain))
	                    {
	                        do_move = true;
	                    }
                    
	                    if(!do_move)
	                    {
	                        if(object_is_child(body, guy_obj) && was_touching && body.holding_wall)
	                        {
	                            var facing_block = instance_position(x+facing*24 +x_diff, bbox_top +y_diff, ter);
                            
	                            if(facing_block != noone)
	                            {
	                                do_move = true;
	                            }
	                        }
	                    }
                
	                    if(!do_move && is_colliding && moved_by_terrain)
	                    {
	                        if(!place_meeting(pre_tp_x, pre_tp_y, supported_terrain))
	                        {
	                            undo_move = true;   
	                        }
	                    }
                    
                    
	                    if(do_move)
	                    {
	                        if(!moved_by_terrain)
	                        {
	                            pre_tp_x = x;
	                            pre_tp_y = y;
	                        }
                    
	                        x += x_diff;
	                        y += y_diff;
                        
	                        has_tped = true;
	                        moved_by_terrain = true;
	                    }
	                    else if(undo_move)
	                    {
	                        x = pre_tp_x;   
	                        y = pre_tp_y;
	                    }
	                }
	            }
	        }
	    }
	}



}
