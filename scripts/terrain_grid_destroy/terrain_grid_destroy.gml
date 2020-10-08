/// @description terrain_grid_destroy(grid_obj)
/// @function terrain_grid_destroy
/// @param grid_obj
function terrain_grid_destroy(argument0) {
	var obj = argument0, xx, yy;

	if(!instance_exists(obj))
	    return false;

	if(!ds_exists(obj.terrain_grid, ds_type_grid))
	    return false;
        
	with(obj)
	{
	    for(xx=0; xx<grid_width; xx+=1)
	    {
	        for(yy=0; yy<grid_height; yy+=1)
	        {
	            ds_list_destroy(ds_grid_get(terrain_grid,xx,yy));
	        }
	    }
	    ds_grid_destroy(terrain_grid);
    
	    grid_width = 0;
	    grid_height = 0;
	    terrain_grid = noone;
	}

	return true;



}
