/// @param {Bool} forced
/// @param {String} name
/// @param {Constant.DsType|Constant.All} type
/// @param {Id.Instance|Constant.All} instance
/// @param {Asset.GMObject|Constant.All} object default = all
function clean_up_ds(forced, name, type, instance, object = all) {
    var objectName = "invalid";

    if (object != all && object_exists(object)) {
        objectName = object_get_name(object);
    }

    var count = ds_list_size(DB.ds_registry);

    for (var i = count - 1; i >= 0; i--) {
        var entry = DB.ds_registry[| i];

        if (name != "" && name != entry.name) {
            continue;
        }

        if (type != all && type != entry.type) {
            continue;
        }

        if (instance != all && instance != entry.instance) {
            continue;
        }

        if (object != all && objectName != entry.objectName) {
            continue;
        }

        if (forced || !instance_exists(entry.instance)) {
            switch (entry.type) {
                case ds_type_list:
                    ds_list_destroy(entry.id);
                    break;
                case ds_type_map:
                    ds_map_destroy(entry.id);
                    break;
                case ds_type_grid:
                    ds_grid_destroy(entry.id);
                    break;
            }

            deregister_ds(entry.type, entry.id);
        }
    }
}
