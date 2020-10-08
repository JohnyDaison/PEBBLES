/// @description Init the terrain grid
/// @function terrain_grid_init
/// @param grid_obj
/// @param [cell_size]
function terrain_grid_init(argument0) {
	var obj = argument0, xx, yy;

	if(!instance_exists(obj))
	    return false;

	with(obj)
	{
	    grid_margin = 0;
	    if(instance_exists(gamemode_obj))
	    {
	        if(instance_exists(gamemode_obj.world))
	        {
	            grid_margin = gamemode_obj.world.current_place.margin;
	        }
	        else
	        {
	            show_debug_message("gamemode_obj.world doesn't exist!")
	        }
	    }
    
	    grid_width = ceil((room_width-2*grid_margin)/grid_cell_size);
	    grid_height = ceil((room_height-2*grid_margin)/grid_cell_size);
	    terrain_grid = ds_grid_create(grid_width,grid_height);
    
	    // TODO: this shouldn't happen all at start, but be done on demand
	    for(xx=0; xx<grid_width; xx+=1)
	    {
	        for(yy=0; yy<grid_height; yy+=1)
	        {
	            ds_grid_set(terrain_grid, xx, yy, ds_list_create());
	        }
	    }
	}
    
	return true;



}
