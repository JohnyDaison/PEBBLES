/// @description my_instance_place(x, y, type)
/// @param x
/// @param y
/// @param type
function my_instance_place() {

	var xx = argument[0];
	var yy = argument[1];
	var type = argument[2];

	var result = noone;

	if(type > coltypes_max)
	{
	    if(object_exists(type) || instance_exists(type))
	    {
	        return instance_place(xx, yy, type);
	    }
	    else
	    {
	        return noone;   
	    }
	}

	//var coll_params = get_cached_collision_params(type, who);

	/*
	if(type == coltype_blocking)
	{
	    /*
	    var param_count = ds_list_size(coll_params);
	    for(var param_i = 0; param_i < param_count && result == noone; param_i++)
	    {
	        result = instance_place(xx, yy, coll_params[| param_i]);
	    }
	    */
    
	    /*
	    if(blocked_by_terrain || blocked_by_solid_terrain)
	    {
	        var ter_type;
        
	        if(!blocked_by_terrain)
	        {
	            ter_type = solid_terrain_obj;
	        }
	        else
	        {
	            ter_type = terrain_obj;
	        }

	        if(result == noone)
	        {
	            result = instance_place(xx, yy, ter_type);
	        }
	    }
	    */

	    /*    
	    if(blocked_by_perma_structure)
	    {
	        if(result == noone)
	        {
	            result = instance_place(xx, yy, perma_wall_structure_obj);
	        }
	    }
	    */
    
	    /*
	    if(blocked_by_gate_field)
	    {
	        if(result == noone)
	        {
	            result = instance_place(xx, yy, gate_field_obj);
	        }
	    }
    
	}
	*/

	return result;


}
