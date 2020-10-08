/// @description register_ds(name, type, id, instance)
/// @function register_ds
/// @param name
/// @param  type
/// @param  id
/// @param  instance
function register_ds(argument0, argument1, argument2, argument3) {
	var name = argument0;
	var type = argument1;
	var ds_id = argument2;
	var instance = argument3;
	var object = noone;

	var map = ds_map_create();
	map[? "name"] = name;
	map[? "type"] = type;
	map[? "id"] = ds_id;
	map[? "instance"] = noone;

	if(instance_exists(instance))
	{
	    map[? "instance"] = instance;    
	    object = instance.object_index;        
	}

	if(object_exists(object))
	{
	    object = object_get_name(object);    
	}
	else
	{
	    object = "invalid";
	}

	map[? "object"] = object;

	ds_list_add(DB.ds_registry, map);
	DB.ds_registry_index[? string(type) + string(ds_id)] = map;



}
