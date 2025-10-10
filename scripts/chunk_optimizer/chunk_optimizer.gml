enum CHUNK_OPTIMIZER_MODE {
    NO_CHANGE,
    ACTIVATE,
    HOLD
}

/// @returns {Real} Number of objects affected, or -1 if grid doesn't exist
function chunk_optimizer() {
    static modeStrings = [
        "no change",
        "activate",
        "hold"
    ];

    var gridInst = noone;
    var debug = false;

    if (instance_exists(chunkgrid_obj)) {
        gridInst = chunkgrid_obj.id;
    } else {
        return -1;
    }

    var objects_affected = 0;
    var max_observer_range = gridInst.observer_range;

    if (!gridInst.do_optimization || singleton_obj.step_count <= 5
        || (gridInst.grid_width <= (2 * max_observer_range + 1) && gridInst.grid_height <= (2 * max_observer_range + 1))) {
        return 0;
    }

    var observer_count = ds_list_size(gridInst.observers);

    if (observer_count == 0) {
        return 0;
    }

    // OBSERVER COUNTS UPDATE
    for (var obs = 0; obs < observer_count; obs++) {
        var observer = gridInst.observers[| obs];
        var observer_range = observer.observer_range;
        var cur_grid_x = floor(observer.x / gridInst.chunk_size);
        var cur_grid_y = floor(observer.y / gridInst.chunk_size);

        // GRID SECTION STATE UPDATE - move this to a function
        if (cur_grid_x != observer.obs_chunk_x || cur_grid_y != observer.obs_chunk_y) {
            var remove = true;
            
            repeat(2)
            {
                var start_x = observer.obs_chunk_x;
                var start_y = observer.obs_chunk_y;
                
                if (start_x > -1 && start_y > -1) {
                    var min_x = start_x - observer_range;
                    var max_x = start_x + observer_range;
                    var min_y = start_y - observer_range;
                    var max_y = start_y + observer_range;

                    // MAKE SURE EDGES ARE INSIDE GRID
                    min_x = clamp(min_x, 0, gridInst.grid_width - 1);
                    max_x = clamp(max_x, 0, gridInst.grid_width - 1);
                    min_y = clamp(min_y, 0, gridInst.grid_height - 1);
                    max_y = clamp(max_y, 0, gridInst.grid_height - 1);

                    for (var xx = min_x; xx <= max_x; xx += 1) {
                        for (var yy = min_y; yy <= max_y; yy += 1) {
                            // observer distance
                            if (point_distance(start_x, start_y, xx, yy) < observer_range + 0.5) {
                                var chunk = gridInst.grid[# xx, yy];

                                if (remove) {
                                    chunk.observerCount -= 1;
                                }
                                else {
                                    chunk.observerCount += 1;
                                }
                            }
                        }
                    }
                }

                // UPDATE OBSERVER'S CHUNK COORDINATES
                observer.obs_chunk_x = cur_grid_x;
                observer.obs_chunk_y = cur_grid_y;
                
                // SWITCH REMOVE TO ADD
                remove = false;

                if (debug) {
                    my_console_log("OBSERVER MOVED TO x: " + string(cur_grid_x) + " y: " + string(cur_grid_y));
                    my_console_log("GRID SIZE IS x: " + string(gridInst.grid_width) + " y: " + string(gridInst.grid_height));
                }
            }
        }
    }


    // DO OBJECT TRANSFORM BASED ON STATE CHANGE
    for (var xx = 0; xx < gridInst.grid_width; xx += 1) {
        for (var yy = 0; yy < gridInst.grid_height; yy += 1) {
            var chunk = gridInst.grid[# xx, yy];
            var mode = CHUNK_OPTIMIZER_MODE.NO_CHANGE;

            chunk.active = chunk.observerCount > 0;

            if (gamemode_obj.mode == "rougelike" && chunk.active && !chunk.generated) {
                chunk_generate(xx, yy, gridInst.seed);
            }

            if (chunk.prevActive && !chunk.active) {
                mode = CHUNK_OPTIMIZER_MODE.HOLD;
            }
            else if (!chunk.prevActive && chunk.active) {
                mode = CHUNK_OPTIMIZER_MODE.ACTIVATE;
            }

            if (mode != CHUNK_OPTIMIZER_MODE.NO_CHANGE) {
                // TERRAIN
                var terArray = chunk.terrainArray;
                var terArraySize = array_length(terArray);

                for (var item = 0; item < terArraySize; item++) {
                    var obj = terArray[item];

                    if (mode == CHUNK_OPTIMIZER_MODE.ACTIVATE) {
                        objects_affected += object_transform(obj);
                    }
                    else if (mode == CHUNK_OPTIMIZER_MODE.HOLD) {
                        objects_affected += object_transform(obj, data_holder_obj);
                    }
                }

                // NON-TERRAIN
                var array = chunk.nonTerrainArray;
                var arraySize = array_length(array);

                for (var item = arraySize - 1; item >= 0; item--) {
                    var obj = array[item];
                    var undef = is_undefined(obj);

                    if (!undef && instance_exists(obj)) {
                        if (mode == CHUNK_OPTIMIZER_MODE.ACTIVATE) {
                            objects_affected += object_transform(obj);
                        }
                        else if (mode == CHUNK_OPTIMIZER_MODE.HOLD) {
                            objects_affected += object_transform(obj, data_holder_obj);
                        }
                    }
                    else {
                        // DELETE ITEM
                        array_delete(array, item , 1);
                        
                        // LOG ERROR
                        var error_str = "CHUNK[" + string(xx) + "," + string(yy) + "]:";

                        if (undef) {
                            error_str += " invalid";
                        }

                        error_str += " non-terrain member";

                        if (!undef) {
                            error_str += " doesn't exist";
                        }

                        error_str += ": " + string(item) + " " + string(obj);

                        if (!is_undefined(gridInst.obj_indexes[? obj])) {
                            error_str += " " + object_get_name(gridInst.obj_indexes[? obj]);
                        }
                        else {
                            error_str += " index unknown";
                        }

                        my_console_log(error_str);
                    }
                }

                // FINISH STATE CHANGE
                chunk.prevActive = chunk.active;

                if (debug) {
                    var update_str = "CHUNK[" + string(xx) + "," + string(yy) + "]: " + modeStrings[mode];

                    my_console_log(update_str);
                }
            }
        }
    }

    return objects_affected;
}
