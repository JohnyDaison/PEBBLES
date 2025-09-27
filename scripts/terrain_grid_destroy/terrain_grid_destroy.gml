/// @param {Id.Instance} grid_obj
function terrain_grid_destroy(grid_obj) {
    if (!instance_exists(grid_obj))
        return false;

    if (!ds_exists(grid_obj.terrain_grid, ds_type_grid))
        return false;

    with (grid_obj) {
        for (var xx = 0; xx < self.grid_width; xx++) {
            for (var yy = 0; yy < self.grid_height; yy++) {
                ds_list_destroy(self.terrain_grid[# xx, yy]);
            }
        }

        ds_grid_destroy(self.terrain_grid);

        self.grid_width = 0;
        self.grid_height = 0;
        self.terrain_grid = undefined;
    }

    return true;
}
