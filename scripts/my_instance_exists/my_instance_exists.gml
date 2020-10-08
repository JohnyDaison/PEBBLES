/// @description my_instance_exists(type, who)
/// @param type
/// @param who
function my_instance_exists() {

	var type = argument[0];
	var who = argument[1];
	var result = false;

	if(type > coltypes_max)
	{
	    if(object_exists(type) || instance_exists(type))
	    {
	        return instance_exists(type);
	    }
	    else
	    {
	        return false;   
	    }
	}

	//var coll_params = get_cached_collision_params(type, who);

	/*
	if(type == coltype_blocking)
	{
	    /*
	    var param_count = ds_list_size(coll_params);
	    for(var param_i = 0; param_i < param_count && !result; param_i++)
	    {
	        result = result || instance_exists(coll_params[| param_i]);
	    }
	    */
    
	    /*
	    if(who.blocked_by_terrain || who.blocked_by_solid_terrain)
	    {
	        var ter_type;
        
	        if(!who.blocked_by_terrain)
	        {
	            ter_type = solid_terrain_obj;
	        }
	        else
	        {
	            ter_type = terrain_obj;
	        }

	        result = result || instance_exists(ter_type);
	    }

	    /*
	    if(who.blocked_by_perma_structure)
	    {
	        result = result || instance_exists(perma_wall_structure_obj);
	    }
	    */
    
	    /*
	    if(who.blocked_by_gate_field)
	    {
	        result = result || instance_exists(gate_field_obj);
	    }
	}
	*/

	return result;


}
