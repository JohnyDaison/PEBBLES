/// @description my_instance_place_list(x, y, type, list, ordered)
/// @param x
/// @param y
/// @param type
/// @param list
/// @param ordered
function my_instance_place_list() {

	var xx = argument[0];
	var yy = argument[1];
	var type = argument[2];
	var list = argument[3];
	var ordered = argument[4];

	var result = 0;

	ds_list_clear(list);

	if(type > coltypes_max)
	{
	    if(object_exists(type))
	    {
	        return instance_place_list(xx, yy, type, list, ordered);
	    }
	    else
	    {
	        return 0;   
	    }
	}

	//var coll_params = get_cached_collision_params(type, who);

	/*
	if(type == coltype_blocking)
	{
	    /*
	    var param_count = ds_list_size(coll_params);
	    for(var param_i = 0; param_i < param_count; param_i++)
	    {
	        result += instance_place_list(xx, yy, coll_params[| param_i], list, ordered);
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

	        result += instance_place_list(xx, yy, ter_type, list, ordered);
	    }
    
	    /*
	    if(blocked_by_perma_structure)
	    {
	        result += instance_place_list(xx, yy, perma_wall_structure_obj, list, ordered);
	    }
	    */
	    /*
	    if(blocked_by_gate_field)
	    {
	        result += instance_place_list(xx, yy, gate_field_obj, list, ordered);
	    }
    
	}
	*/

	/*
	if(ds_list_size(list) != result)
	{
	    my_console_log("my_instance_place_list: list is reset instead of accumulated")  
	}
	*/

	return result;


}
