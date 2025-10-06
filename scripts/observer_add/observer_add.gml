/// @param {Asset.GMObject} grid_obj
/// @param {Id.Instance} observer
function observer_add(grid_obj, observer) {
    if (!instance_exists(grid_obj)) {
        return false;
    }

    ds_list_add(grid_obj.observers, observer.id);

    observer.my_chunkgrid = grid_obj.id;
    observer.obs_chunk_x = -1;
    observer.obs_chunk_y = -1;

    return true;
}
