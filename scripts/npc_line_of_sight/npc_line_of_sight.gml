/// @param xx
/// @param yy
/// @param type "attack" or "move"
function npc_line_of_sight() {
	var xx = argument[0];
	var yy = argument[1];
	var type = argument[2];
	var npc_player = noone;

	if(argument_count > 3)
	{
	    npc_player = argument[3];
	}
	else
	{
	    npc_player = my_player;
	}

	var can_see = false;
	var blocker = noone;

	if(type == "move")
	{
	    if(blocker == noone)
	    {
	        blocker = collision_line(x,y, xx, yy, terrain_obj, false, false);       
	    }
    
	    if(blocker == noone)
	    {
	        blocker = collision_line(x + 4*facing, y - 8, xx, yy, terrain_obj, false, false);     
	    }
    
	    if(blocker == noone)
	    {
	        blocker = collision_line(x, y, xx, yy, one_way_pass_obj, false, false);      
        
	        if(instance_exists(blocker) && blocker.my_player == npc_player)
	        {
	            blocker = noone;
	        }
	    }
    
	    if(blocker == noone)
	    {
	        blocker = collision_line(x, y, xx, yy, gate_field_obj, false, false);     
	    }
    
	    if(blocker == noone)
	    {
	        var result_i, result_number, result, blocker_shields = ds_list_create();
	        result_number = collision_line_list(x, y, xx, yy, shield_obj, false, false, blocker_shields, false);     
        
	        for(result_i = 0; result_i < result_number; result_i++)
	        {
	            result = blocker_shields[| result_i];
	            if(result.my_player != my_player && instance_exists(result.my_guy) && result.my_guy.immovable)
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
	        blocker = collision_line(x,y, xx, yy, solid_terrain_obj, false, false);       
	    }
    
	    if(blocker == noone)
	    {
	        blocker = collision_line(x + 4*facing, y - 8, xx, yy, solid_terrain_obj, false, false);   
	    }
    
	    if(blocker == noone)
	    {
	        blocker = collision_line(x, y, xx, yy, gate_field_obj, false, false);     
	    }
    
	    can_see = (blocker == noone);
	}

	return can_see;


}
