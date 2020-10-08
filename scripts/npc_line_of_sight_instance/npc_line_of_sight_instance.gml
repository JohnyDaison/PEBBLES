/// @param instance
/// @param type "attack" or "move"
function npc_line_of_sight_instance() {
	var target = argument[0];
	var type = argument[1];
	var npc_player = noone;

	if(argument_count > 2)
	{
	    npc_player = argument[2];
	}
	else
	{
	    npc_player = my_player;
	}

	var can_see = false;
	var blocker = noone;
	var guy = id;

	with(target)
	{
	    if(type == "move")
	    {
	        if(blocker == noone)
	        {
	            blocker = collision_line(guy.x,guy.y, x, y, terrain_obj, false, true);       
	        }
    
	        if(blocker == noone)
	        {
	            blocker = collision_line(guy.x + 4*guy.facing, guy.y - 8, x, y, terrain_obj, false, true);     
	        }
    
	        if(blocker == noone)
	        {
	            blocker = collision_line(guy.x, guy.y, x, y, one_way_pass_obj, false, true);      
        
	            if(instance_exists(blocker) && blocker.my_player == npc_player)
	            {
	                blocker = noone;
	            }
	        }
    
	        if(blocker == noone)
	        {
	            blocker = collision_line(guy.x, guy.y, x, y, gate_field_obj, false, true);     
	        }
        
	        if(blocker == noone)
	        {
	            var result_i, result_number, result, blocker_shields = ds_list_create();
	            result_number = collision_line_list(guy.x, guy.y, x, y, shield_obj, false, true, blocker_shields, false);     
        
	            for(result_i = 0; result_i < result_number; result_i++)
	            {
	                result = blocker_shields[| result_i];
	                if(result.my_player != guy.my_player && instance_exists(result.my_guy) && result.my_guy.immovable)
	                {
	                    blocker = result;
	                    break;
	                }
	            }
                
	            ds_list_destroy(blocker_shields);
	        }
    
	        can_see = (blocker == noone);
	    }
	    else if(type == "attack")
	    {
	        if(blocker == noone)
	        {
	            blocker = collision_line(guy.x,guy.y, x, y, solid_terrain_obj, false, true);       
	        }
    
	        if(blocker == noone)
	        {
	            blocker = collision_line(guy.x + 4*guy.facing, guy.y - 8, x, y, solid_terrain_obj, false, true);   
	        }
    
	        if(blocker == noone)
	        {
	            if(object_index == wall_obj)
	            {
	                var wall = id;
	                with(gate_field_obj)
	                {
	                    if(distance_to_object(wall) > 4)
	                    {
	                        blocker = collision_line(guy.x, guy.y, wall.x, wall.y, id, false, false);   
	                    }
	                }
	            }
	            else
	            {
	                blocker = collision_line(guy.x, guy.y, x, y, gate_field_obj, false, true);
	            }
	        }
    
	        can_see = (blocker == noone);
	    }
	}

	return can_see;


}
