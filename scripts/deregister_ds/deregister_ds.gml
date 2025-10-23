/// @param {Constant.DsType|String} type
/// @param {Id.DsList|Id.DsMap|Id.DsGrid} ds_id
function deregister_ds(type, ds_id) {
    var regId = string(type) + string(ds_id);
    var entry = DB.ds_registry_index[? regId];
    var index = ds_list_find_index(DB.ds_registry, entry);

    ds_list_delete(DB.ds_registry, index);
    ds_map_delete(DB.ds_registry_index, regId);
}
