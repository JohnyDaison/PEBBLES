/// @param {Id.DsList} output_list
/// @param {Id.Instance} gridInst
/// @param {Real} x1
/// @param {Real} y1
/// @param {Real} x2
/// @param {Real} y2
/// @param {Bool} only_active
/// @param {String} type default "non_terrain" | "terrain" | "all"
function chunks_content(output_list, gridInst, x1, y1, x2, y2, only_active = false, type = "non_terrain") {
    ds_list_clear(output_list);

    if (!instance_exists(gridInst)) {
        return false;
    }

    // CLAMP COORDS TO BE INSIDE GRID
    x1 = clamp(x1, 0, gridInst.grid_width - 1);
    x2 = clamp(x2, 0, gridInst.grid_width - 1);

    y1 = clamp(y1, 0, gridInst.grid_height - 1);
    y2 = clamp(y2, 0, gridInst.grid_height - 1);

    for (var yy = y1; yy <= y2; yy++) {
        for (var xx = x1; xx <= x2; xx++) {
            var chunk = gridInst.grid[# xx, yy];

            if (!only_active || chunk[? "active"]) {
                if (type == "terrain" || type == "all") {
                    var list = chunk[? "terrain"];
                    var count = ds_list_size(list);

                    for (var i = 0; i < count; i++) {
                        ds_list_add(output_list, list[| i]);
                    }
                }

                if (type == "non_terrain" || type == "all") {
                    var list = chunk[? "non_terrain"];
                    var count = ds_list_size(list);

                    for (var i = 0; i < count; i++) {
                        ds_list_add(output_list, list[| i]);
                    }
                }
            }
        }
    }

    return true;
}
