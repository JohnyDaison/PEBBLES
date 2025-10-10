do_optimization = true;
chunk_size = 512;
grid_width = ceil(room_width / self.chunk_size);
grid_height = ceil(room_height / self.chunk_size);

grid = ds_grid_create(self.grid_width, self.grid_height);
observers = ds_list_create();
observer_range = 3;
seed = random(1000000);
obj_indexes = ds_map_create();

for (var xx = 0; xx < self.grid_width; xx += 1) {
    for (var yy = 0; yy < self.grid_height; yy += 1) {
        var chunk = ds_map_create();
        
        chunk[? "observers"] = 0;
        chunk[? "generated"] = false;
        chunk[? "active"] = true;
        chunk[? "prev_active"] = true;
        chunk[? "terrain"] = ds_list_create();
        chunk[? "non_terrain"] = ds_list_create();
        
        self.grid[# xx, yy] = chunk;
    }
}
