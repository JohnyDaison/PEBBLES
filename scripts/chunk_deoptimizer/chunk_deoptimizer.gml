function chunk_deoptimizer() {
    if (!instance_exists(chunkgrid_obj)) {
        return 0;
    }

    var grid_obj = chunkgrid_obj.id;

    var objects_affected = 0;

    with (grid_obj) {
        if (!self.do_optimization) {
            return objects_affected;
        }

        self.do_optimization = false;

        // DO OBJECT TRANSFORM BASED ON STATE CHANGE
        for (var xx = 0; xx < self.grid_width; xx++) {
            for (var yy = 0; yy < self.grid_height; yy++) {
                var chunk = ds_grid_get(self.grid, xx, yy);

                chunk[? "active"] = true;
                
                if (chunk[? "prev_active"]) {
                    continue;
                }
                
                chunk[? "prev_active"] = true;
                
                // TERRAIN
                var ter_list = chunk[? "terrain"];
                var ter_list_size = ds_list_size(ter_list);

                for (var item = 0; item < ter_list_size; item++) {
                    var obj = ter_list[| item];

                    objects_affected += object_transform(obj);
                }

                // NON-TERRAIN
                var non_ter_list = chunk[? "non_terrain"];
                var non_ter_list_size = ds_list_size(non_ter_list);

                for (var item = 0; item < non_ter_list_size; item++) {
                    var obj = non_ter_list[| item];
                    var undef = is_undefined(obj);

                    if (!undef && instance_exists(obj)) {
                        objects_affected += object_transform(obj);
                    }
                    else {
                        var error_str = "CHUNK[" + string(xx) + "," + string(yy) + "]:";

                        if (undef) {
                            error_str += " invalid";
                        }

                        error_str += " non-terrain member";

                        if (!undef) {
                            error_str += " doesn't exist";
                        }

                        error_str += ": " + string(item) + " " + string(obj);

                        my_console_log(error_str);
                    }
                }
            }
        }
    }

    return objects_affected;
}
