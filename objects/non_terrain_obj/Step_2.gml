/// @description HANDLE LEAVING CHUNK
// This should be inherited at the end of a script, not the start

if(instance_exists(chunkgrid_obj))
{
    var cur_grid_x, cur_grid_y;
    cur_grid_x = floor(x / chunkgrid_obj.chunk_size);
    cur_grid_y = floor(y / chunkgrid_obj.chunk_size);
    
    // GRID POSITION UPDATE
    if(cur_grid_x != chunkgrid_x || cur_grid_y != chunkgrid_y)
    {
        chunk_deregister(chunkgrid_obj, id);
        //chunk_register(chunkgrid_obj, id); This doesn't work in the same step because of instance_change.
        alarm[7] = 1;
    }
}

