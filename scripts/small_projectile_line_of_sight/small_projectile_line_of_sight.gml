/// @description small_projectile_line_of_sight(from_x, from_y, target)
/// @function small_projectile_line_of_sight
/// @param from_x
/// @param from_y
/// @param target
function small_projectile_line_of_sight() {
	var from_x = argument[0];
	var from_y = argument[1];
	var target = argument[2];
	var result = false;

	if(instance_exists(target))
	{
	    var blocked = false;
    
	    var ter = collision_line(from_x,from_y, target.x,target.y, solid_terrain_obj, false, false);
    
	    if(ter != noone)
	    {
	        blocked = true;   
	    }
    
	    /*
	    var structure = collision_line(from_x,from_y, target.x,target.y, perma_wall_structure_obj, false, false);
    
	    if(structure != noone)
	    {
	        blocked = true;   
	    }
	    */
    
	    var gate = collision_line(from_x,from_y, target.x,target.y, gate_field_obj, false, false);
    
	    if(gate != noone)
	    {
	        blocked = true;   
	    }
    
	    if(!blocked)
	    {
	        var structure = collision_line(from_x,from_y, target.x,target.y, cannon_base_obj, false, false);
        
	        if(structure != noone && structure.my_player == my_player)
	        {
	            blocked = true;
	        }
	    }
    
	    if(!blocked)
	    {
	        var body = collision_line(from_x,from_y, target.x,target.y, phys_body_obj, false, false);
        
	        if(body != noone && body.my_player == my_player)
	        {
	            blocked = true;
	        }
	    }
    
	    result = !blocked;
	}

	return result;



}
