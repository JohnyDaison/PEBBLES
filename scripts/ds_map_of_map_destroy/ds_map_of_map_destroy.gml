/// @description ds_map_of_map_destroy(map);
/// @function ds_map_of_map_destroy
/// @param map
function ds_map_of_map_destroy(argument0) {
	var main_map = argument0;

	var main_key, sub_map;

	main_key = ds_map_find_first(main_map);

	while(!is_undefined(main_key))
	{
	    sub_map = main_map[? main_key];
	    ds_map_destroy(sub_map);
    
	    ds_map_find_next(main_map, main_key);
	}

	ds_map_destroy(main_map);



}
