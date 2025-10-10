/// @param {Id.Instance|Asset.GMObject} gridObj
/// @param {Id.Instance} gameInst
function chunk_register(gridObj, gameInst) {
    var gridInst = gridObj.id;
    var ret = false;
    var schedule_optimizer = false;
    var target_is_observer = ds_list_find_index(gridInst.observers, gameInst) > -1;

    // IF OBSERVER LEFT A CHUNK, RUN OPTIMIZER
    if (target_is_observer && !is_undefined(gameInst.myChunkArray)) {
        schedule_optimizer = true;
    }

    // CALCULATE CHUNK
    var xx = floor(gameInst.x / gridInst.chunk_size);
    var yy = floor(gameInst.y / gridInst.chunk_size);

    if (xx >= 0 && xx < gridInst.grid_width && yy >= 0 && yy < gridInst.grid_height) {
        // IF OBSERVER ARRIVED IN NEW CHUNK, RUN OPTIMIZER
        if (target_is_observer) {
            if (is_undefined(gameInst.myChunkArray)) {
                chunk_optimizer();
            }
            else {
                schedule_optimizer = true;
            }
        }

        var chunk = gridInst.grid[# xx, yy];
        var id_str;

        if (DB.console_mode == CONSOLE_MODE.DEBUG) {
            id_str = "CHUNK[" + string(xx) + "," + string(yy) + "]: " + string(gameInst.id) + " " + object_get_name(gameInst.object_index);
        }

        // TERRAIN
        if (object_is_ancestor(gameInst.object_index, terrain_obj)) {
            var ter = gameInst;

            ter.myChunkArray = chunk.terrainArray;
            ter.chunkgrid_x = xx;
            ter.chunkgrid_y = yy;

            if (!is_undefined(ter.myChunkArray)) {
                if (array_get_index(ter.myChunkArray, ter.id) != -1) {
                    if (DB.console_mode == CONSOLE_MODE.DEBUG) {
                        my_console_log("ERROR: Trying to re-add terrain " + id_str);
                    }
                    ret = false;
                }
                else {
                    array_push(ter.myChunkArray, ter.id);

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

            entity.myChunkArray = chunk.nonTerrainArray;
            entity.chunkgrid_x = xx;
            entity.chunkgrid_y = yy;

            if (!is_undefined(entity.myChunkArray)) {
                if (array_get_index(entity.myChunkArray, entity.id) != -1) {
                    if (DB.console_mode == CONSOLE_MODE.DEBUG) {
                        my_console_log("ERROR: Trying to re-add entity " + id_str);
                    }
                    ret = false;
                }
                else {
                    array_push(entity.myChunkArray, entity.id);

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
            if (!chunk.active) {
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
