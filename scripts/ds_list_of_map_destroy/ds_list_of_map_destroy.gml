/// @param {Id.DsList} list
function ds_list_of_map_destroy(list) {
    var count = ds_list_size(list);

    for (var i = count - 1; i >= 0; i--) {
        ds_map_destroy(list[| i]);
    }

    ds_list_destroy(list);
}
