/// @description chunk_generate(chunk_x, chunk_y, seed, [chunkgrid])
/// @function chunk_generate
/// @param chunk_x
/// @param chunk_y
/// @param seed
/// @param [chunkgrid]
function chunk_generate() {

	var chunk_x = argument[0];
	var chunk_y = argument[1];
	var seed = argument[2];
	var grid_obj = noone;

	if(argument_count > 3)
	{
	    grid_obj = argument[3];   
	}
	else
	{
	    if(instance_exists(chunkgrid_obj))
	    {
	        grid_obj = chunkgrid_obj.id;
	    }
	}

	with(grid_obj)
	{
	    var chunk, xx, yy;
	    chunk = ds_grid_get(grid, chunk_x, chunk_y);
    
	    var left_x = chunk_size * chunk_x;
	    var right_x = chunk_size * (chunk_x+1);
	    var top_y = chunk_size * chunk_y;
	    var bottom_y = chunk_size * (chunk_y+1);
    
	    if(left_x < singleton_obj.grid_margin || right_x > (room_width-singleton_obj.grid_margin)
	    || top_y < singleton_obj.grid_margin || bottom_y > (room_height-singleton_obj.grid_margin))
	    {
	        return false;
	    }
    
	    random_set_seed(seed);
    
	    for(xx = left_x; xx < right_x; xx += 32)
	    {
	        for(yy = top_y; yy < bottom_y; yy += 32)
	        {
	            if(random(15) < 1)
	            {
	                if(!collision_point(xx, yy, terrain_obj, false, false))
	                {
	                    instance_create(xx, yy, wall_obj);
	                }
	            }
	            if(random(40) < 1)
	            {
	                if(!collision_point(xx, yy, terrain_obj, false, false))
	                {
	                    instance_create(xx, yy, platform_obj);
	                }
	            }
	        }
	    }
    
	    chunk[? "generated"] = true;    
	}

	return true;


}
