/// @param {String} name
/// @param {Constant.DsType|String} type
/// @param {Id.DsList|Id.DsMap|Id.DsGrid} ds_id
/// @param {Id.Instance} instance
function register_ds(name, type, ds_id, instance) {
    var regId = string(type) + string(ds_id);
    var entry = new DsRegistryEntry(name, type, ds_id, instance);

    ds_list_add(DB.ds_registry, entry);
    DB.ds_registry_index[? regId] = entry;
}
