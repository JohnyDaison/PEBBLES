/// @description terrain_deregister(grid_obj, terrain_obj)
/// @function terrain_deregister
/// @param grid_obj
/// @param terrain_obj
function terrain_deregister(argument0, argument1) {
	var obj = argument0;
	var ter = argument1;

	var wall, i, count, other_ter;
	/*
	if(!instance_exists(obj) || !instance_exists(ter))
	    return false;
	*/
	if(!ds_exists(obj.terrain_grid, ds_type_grid))
	    return false;

	if(is_undefined(ter.my_list) || !ds_exists(ter.my_list, ds_type_list))
	    return false;

	if(ter.object_index == wall_obj)    
	{
	    for(i=0;i<4;i+=1)
	    {
	        wall = ter.near_walls[? i];
	        if(instance_exists(wall))
	        {
	            wall.alarm[0] = 1;
	        }
	        ter.near_walls[? i] = noone;
	    }
	}
            
	ds_list_delete(ter.my_list,ds_list_find_index(ter.my_list,ter.id));

	count = ds_list_size(ter.my_list);

	if(ter.error_placement)
	{
	    for(i = 0; i < count; i++)
	    {
	        other_ter = ter.my_list[| i];    
        
	        if(other_ter.aligned_x == ter.aligned_x && other_ter.aligned_y == ter.aligned_y)
	        {
	            other_ter.error_placement = false;
	        }
	    }
	}

	ter.my_list = noone;
	ter.grid_x = -1;
	ter.grid_y = -1;
	ter.error_placement = false;

	if(instance_exists(chunkgrid_obj))
	{
	    chunk_deregister(chunkgrid_obj, ter);
	}

	return true;



}
