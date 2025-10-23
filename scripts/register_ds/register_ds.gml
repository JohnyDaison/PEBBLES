/// @param {String} name
/// @param {Constant.DsType|String} type
/// @param {Id.DsList|Id.DsMap|Id.DsGrid} ds_id
/// @param {Id.Instance} instance
function register_ds(name, type, ds_id, instance) {
    var objectStr = "invalid";

    var map = ds_map_create();
    map[? "name"] = name;
    map[? "type"] = type;
    map[? "id"] = ds_id;
    map[? "instance"] = noone;

    if (instance_exists(instance)) {
        map[? "instance"] = instance;
        objectStr = object_get_name(instance.object_index);
    }

    map[? "object"] = objectStr;

    ds_list_add(DB.ds_registry, map);
    DB.ds_registry_index[? string(type) + string(ds_id)] = map;
}
