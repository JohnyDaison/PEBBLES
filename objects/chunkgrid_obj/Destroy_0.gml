for (var xx = 0; xx < self.grid_width; xx += 1) {
    for (var yy = 0; yy < self.grid_height; yy += 1) {
        var chunk = self.grid[# xx, yy];
        
        ds_list_destroy(chunk[? "terrain"]);
        ds_list_destroy(chunk[? "non_terrain"]);
        
        ds_map_destroy(chunk);
    }
}

ds_grid_destroy(self.grid);
ds_list_destroy(self.observers);
ds_map_destroy(self.obj_indexes);
