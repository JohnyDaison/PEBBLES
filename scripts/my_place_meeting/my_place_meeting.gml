/// @description my_place_meeting(x, y, type)
/// @param x
/// @param y
/// @param type
function my_place_meeting() {

	var xx = argument[0];
	var yy = argument[1];
	var type = argument[2];
	var who = id;
	var result = false;

	if(type > coltypes_max)
	{
	    if(object_exists(type) || instance_exists(type))
	    {
	        return place_meeting(xx, yy, type);
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
	        result = result || place_meeting(xx, yy, coll_params[| param_i]);
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

	        result = result || place_meeting(xx, yy, ter_type);
	    }

	    /*
	    if(blocked_by_perma_structure)
	    {
	        result = result || place_meeting(xx, yy, perma_wall_structure_obj);
	    }
	    */
    
	    /*
	    if(blocked_by_gate_field)
	    {
	        result = result || place_meeting(xx, yy, gate_field_obj);
	    }
	}
	*/

	return result;


}
