/// @description observer_add(grid_obj, observer_obj)
/// @function observer_add
/// @param grid_obj
/// @param  observer_obj
function observer_add(argument0, argument1) {
	var grid_obj = argument0;
	var target = argument1;
	var count = 0;

	if(instance_exists(grid_obj))
	{
	    with(target)
	    {
	        ds_list_add(grid_obj.observers, id);
	        my_chunkgrid = grid_obj.id;
	        obs_chunk_x = -1;
	        obs_chunk_y = -1;
	        count++;        
	    }
	}

	return count;



}
