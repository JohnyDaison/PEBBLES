/// @description chunk_deregister(grid_obj, game_obj)
/// @function chunk_deregister
/// @param grid_obj
/// @param  game_obj
function chunk_deregister(argument0, argument1) {
	var grid_obj = argument0;
	var target = argument1;

	if(!ds_exists(grid_obj.grid, ds_type_grid))
	    return false;

	if(is_undefined(target.my_chunklist) || !ds_exists(target.my_chunklist, ds_type_list))
	    return false;
    
	if(target.object_index == data_holder_obj)
	{
	    object_transform(target);
	}
    
	ds_list_delete(target.my_chunklist,ds_list_find_index(target.my_chunklist,target.id));

	target.my_chunklist = noone;

	return true;



}
