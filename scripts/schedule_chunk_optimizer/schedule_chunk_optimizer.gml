/// @description schedule_chunk_optimizer([chunkgrid])
/// @function schedule_chunk_optimizer
/// @param [chunkgrid]
function schedule_chunk_optimizer() {
	var grid_obj = noone;

	if(argument_count > 0)
	{
	    grid_obj = argument[0];   
	}
	else
	{
	    if(instance_exists(chunkgrid_obj))
	    {
	        grid_obj = chunkgrid_obj.id;
	    }
	}

	if (!object_is_child(grid_obj, chunkgrid_obj))
	{
	    return "Not a chunkgrid!";   
	}

	with(grid_obj)
	{
	    if (alarm[1] == -1)
	    {
	        alarm[1] = 2;
	    }
	}

	return true;



}
