/// @param {Bool} forced
/// @param {String} name
/// @param {Constant.DsType|String|Constant.All} type
/// @param {Id.Instance|Constant.All} instance
/// @param {Asset.GMObject|Constant.All} object default = all
function clean_up_ds(forced, name, type, instance, object = all) {
    var objectName = "invalid";

    if (object != all && object_exists(object)) {
        objectName = object_get_name(object);
    }

    var count = ds_list_size(DB.ds_registry);

    for (var i = count - 1; i >= 0; i--) {
        var info_map = DB.ds_registry[| i];

        if (name != "" && name != info_map[? "name"]) {
            continue;
        }

        if (type != all && type != info_map[? "type"]) {
            continue;
        }

        if (instance != all && instance != info_map[? "instance"]) {
            continue;
        }

        if (object != all && objectName != info_map[? "object"]) {
            continue;
        }

        if (forced || !instance_exists(info_map[? "instance"])) {
            switch (info_map[? "type"]) {
                case ds_type_list:
                    ds_list_destroy(info_map[? "id"]);
                    break;
                case ds_type_map:
                    ds_map_destroy(info_map[? "id"]);
                    break;
                case ds_type_grid:
                    ds_grid_destroy(info_map[? "id"]);
                    break;
            }

            switch (info_map[? "type"]) {
                case "ds_list_of_map":
                    ds_list_of_map_destroy(info_map[? "id"]);
                    break;
                case "ds_map_of_map":
                    ds_map_of_map_destroy(info_map[? "id"]);
                    break;
            }

            deregister_ds(info_map[? "type"], info_map[? "id"]);
        }
    }
}
