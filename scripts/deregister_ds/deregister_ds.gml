/// @param {Constant.DsType|String} type
/// @param {Id.DsList|Id.DsMap|Id.DsGrid} ds_id
function deregister_ds(type, ds_id) {
    var reg_id = string(type) + string(ds_id);

    var info_map = DB.ds_registry_index[? reg_id];

    var index = ds_list_find_index(DB.ds_registry, info_map);

    ds_map_destroy(info_map);
    ds_list_delete(DB.ds_registry, index);
    ds_map_delete(DB.ds_registry_index, reg_id);
}
