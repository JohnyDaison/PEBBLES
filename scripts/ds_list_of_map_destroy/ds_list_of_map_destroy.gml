/// @description ds_list_of_map_destroy(list);
/// @function ds_list_of_map_destroy
/// @param list
function ds_list_of_map_destroy(argument0) {
	var list = argument0;

	var map, count, i;

	count = ds_list_size(list);

	for(i = count-1; i >= 0; i--)
	{
	    map = list[| i];
	    ds_map_destroy(map);
	}

	ds_list_destroy(list);



}
