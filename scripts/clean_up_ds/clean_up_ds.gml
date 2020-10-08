/// @description clean_up_ds(forced, name, type, instance, [object])
/// @function clean_up_ds
/// @param force
/// @param name
/// @param type
/// @param instance
/// @param [object]
function clean_up_ds() {
	var forced = argument[0];
	var name = argument[1];
	var type = argument[2];
	var instance = argument[3];

	var object = all;
	if(argument_count > 4)
	{
	    var object = argument[4];
    
	    if(object_exists(object))
	    {
	        object = object_get_name(object);    
	    }
	    else
	    {
	        object = "invalid";
	    }
	}


	var i, info_map, count = ds_list_size(DB.ds_registry);

	for(i=count-1; i>=0; i--)
	{
	    info_map = DB.ds_registry[| i];
    
	    if(name != "" && name != info_map[? "name"])
	    {
	        continue;
	    }
    
	    if(type != all && type != info_map[? "type"])
	    {
	        continue;
	    }
    
	    if(instance != all && instance != info_map[? "instance"])
	    {
	        continue;
	    }
    
	    if(object != all && object != info_map[? "object"])
	    {
	        continue;
	    }
    
	    if(forced || !instance_exists(info_map[? "instance"]))
	    {
	        switch(info_map[? "type"])
	        {
	            case ds_type_list:
	                ds_list_destroy(info_map[? "id"]);
	                break;
	            case ds_type_map:
	                ds_map_destroy(info_map[? "id"]);
	                break;
	            case ds_type_grid:
	                ds_grid_destroy(info_map[? "id"]);
	                break;
	        }
        
	        switch(info_map[? "type"])
	        {
	            case "ds_list_of_map":
	                ds_list_of_map_destroy(info_map[? "id"]);
	                break;
	            case "ds_map_of_map":
	                ds_map_of_map_destroy(info_map[? "id"]);
	                break;
	        }
        
	        deregister_ds(info_map[? "type"], info_map[? "id"]);
	    }
	}


}
