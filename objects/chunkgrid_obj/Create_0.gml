do_optimization = true;
chunk_size = 512;
grid_width = ceil(room_width/chunk_size);
grid_height = ceil(room_height/chunk_size);

grid = ds_grid_create(grid_width, grid_height);
observers = ds_list_create();
observer_range = 3;
seed = random(1000000);
obj_indexes = ds_map_create();

var xx,yy, chunk;

for(xx=0; xx<grid_width; xx+=1)
{
    for(yy=0; yy<grid_height; yy+=1)
    {
        chunk = ds_map_create();
        chunk[? "observers"] = 0;
        chunk[? "generated"] = false;
        chunk[? "state"] = "active";
        chunk[? "prev_state"] = "active";
        chunk[? "terrain"] = ds_list_create();
        chunk[? "non_terrain"] = ds_list_create();
        ds_grid_set(grid, xx, yy, chunk);
    }
}

