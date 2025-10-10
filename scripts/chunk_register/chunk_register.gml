/// @param {Id.Instance|Asset.GMObject} gridObj
/// @param {Id.Instance} gameInst
function chunk_register(gridObj, gameInst) {
    var gridInst = gridObj.id;
    var ret = false;
    var schedule_optimizer = false;
    var target_is_observer = ds_list_find_index(gridInst.observers, gameInst) > -1;

    // IF OBSERVER LEFT A CHUNK, RUN OPTIMIZER
    if (target_is_observer && gameInst.my_chunklist != noone) {
        schedule_optimizer = true;
    }

    // CALCULATE CHUNK
    var xx = floor(gameInst.x / gridInst.chunk_size);
    var yy = floor(gameInst.y / gridInst.chunk_size);

    if (xx >= 0 && xx < gridInst.grid_width && yy >= 0 && yy < gridInst.grid_height) {
        // IF OBSERVER ARRIVED IN NEW CHUNK, RUN OPTIMIZER
        if (target_is_observer) {
            if (gameInst.my_chunklist == noone) {
                chunk_optimizer();
            }
            else {
                schedule_optimizer = true;
            }
        }

        var chunk = ds_grid_get(gridInst.grid, xx, yy);
        var id_str;

        if (DB.console_mode == "debug") {
            id_str = "CHUNK[" + string(xx) + "," + string(yy) + "]: " + string(gameInst.id) + " " + object_get_name(gameInst.object_index);
        }

        // TERRAIN
        if (object_is_ancestor(gameInst.object_index, terrain_obj)) {
            var ter = gameInst;

            ter.my_chunklist = chunk[? "terrain"];
            ter.chunkgrid_x = xx;
            ter.chunkgrid_y = yy;

            if (!is_undefined(ter.my_chunklist) && ds_exists(ter.my_chunklist, ds_type_list)) {
                if (ds_list_find_index(ter.my_chunklist, ter.id) != -1) {
                    if (DB.console_mode == "debug") {
                        my_console_log("ERROR: Trying to re-add terrain " + id_str);
                    }
                    ret = false;
                }
                else {
                    ds_list_add(ter.my_chunklist, ter.id);

                    if (ter.object_index == wall_obj) {
                        ter.alarm[0] = 1;
                        ter.is_new = true;
                    }

                    ret = true;
                }
            }
        }
        // NON-TERRAIN
        else {
            var entity = gameInst;

            entity.my_chunklist = chunk[? "non_terrain"];
            entity.chunkgrid_x = xx;
            entity.chunkgrid_y = yy;

            if (!is_undefined(entity.my_chunklist) && ds_exists(entity.my_chunklist, ds_type_list)) {
                if (ds_list_find_index(entity.my_chunklist, entity.id) != -1) {
                    if (DB.console_mode == "debug") {
                        my_console_log("ERROR: Trying to re-add entity " + id_str);
                    }
                    ret = false;
                }
                else {
                    ds_list_add(entity.my_chunklist, entity.id);

                    ret = true;
                }
            }
        }

        // ON SUCCESS
        if (ret) {
            if (is_undefined(gridInst.obj_indexes[? gameInst.id])) {
                gridInst.obj_indexes[? gameInst.id] = gameInst.object_index;
            }

            // IF THE NEW CHUNK IS FROZEN
            if (!chunk[? "active"]) {
                // (BECAUSE OF ITEMS FALLING THROUGH TERRAIN):
                // ---
                // POSITION CORRECTION
                gameInst.x -= gameInst.hspeed;
                gameInst.y -= gameInst.vspeed;

                // IF FALLING SLOWLY
                if (abs(gameInst.hspeed) < 2 && gameInst.vspeed > 0 && gameInst.vspeed < 5) {
                    // CANCEL FALL
                    gameInst.vspeed = 0;

                    // ADJUST FOR EDGE-TO-CENTER DISTANCE
                    if (object_is_ancestor(gameInst.object_index, item_obj) ||
                        object_is_ancestor(gameInst.object_index, energyball_obj) ||
                        object_is_ancestor(gameInst.object_index, phys_body_obj) ||
                        object_is_ancestor(gameInst.object_index, structure_obj)) {
                        gameInst.y -= gameInst.radius;
                    }
                }

                if (object_is_child(gameInst.object_index, phys_body_obj)) {
                    gameInst.x -= lengthdir_x(gameInst.radius + 1, gameInst.direction);
                    gameInst.y -= lengthdir_y(gameInst.radius + 1, gameInst.direction);
                }

                //TRANSFORM TO DATA HOLDER
                object_transform(gameInst, data_holder_obj);
            }
        }
    }

    if (schedule_optimizer) {
        schedule_chunk_optimizer();
        my_console_log("SCHEDULE CHUNK OPTIMIZER");
    }

    return ret;
}
