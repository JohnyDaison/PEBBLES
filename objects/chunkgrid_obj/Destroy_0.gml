var xx,yy, chunk;

for(xx=0; xx<grid_width; xx+=1)
{
    for(yy=0; yy<grid_height; yy+=1)
    {
        chunk = ds_grid_get(grid,xx,yy);
        ds_list_destroy(chunk[? "terrain"]);
        ds_list_destroy(chunk[? "non_terrain"]);
        ds_map_destroy(chunk);
    }
}

ds_grid_destroy(grid);
ds_list_destroy(observers);
ds_map_destroy(obj_indexes);
