/// @param {Id.Instance} gridInst
/// @param {Id.Instance} observer
function observer_remove(gridInst, observer) {
    if (!instance_exists(gridInst)) {
        return false;
    }

    var index = ds_list_find_index(gridInst.observers, observer.id);

    if (index == -1) {
        return false;
    }

    var start_x = observer.obs_chunk_x;
    var start_y = observer.obs_chunk_y;
    var observer_range = observer.observer_range;

    if (observer.obs_chunk_x > -1 && observer.obs_chunk_y > -1) {
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
                if (point_distance(observer.obs_chunk_x, observer.obs_chunk_y, xx, yy) < observer_range + 0.5) {
                    var chunk = gridInst.grid[# xx, yy];
                    chunk.observerCount -= 1;
                }
            }
        }
    }

    ds_list_delete(gridInst.observers, index);
    observer.my_chunkgrid = noone;

    return true;
}
