function list_ds() {
    var count = ds_list_size(DB.ds_registry);

    for (var i = 0; i < count; i++) {
        var info_map = DB.ds_registry[| i];
        var typeOfType = typeof (info_map[? "type"]);
        var ds_exists_str = "ghost", inst_exists_str = "dead";

        if (typeOfType == "number" && ds_exists(info_map[? "id"], info_map[? "type"])) {
            ds_exists_str = "exists";
        }

        if (instance_exists(info_map[? "instance"])) {
            inst_exists_str = "exists";
        }


        my_console_write(
            info_map[? "name"] + " (" + string(info_map[? "type"]) + ":" + string(info_map[? "id"]) + ") "
            + ds_exists_str + " on "
            + info_map[? "object"] + " (" + string(info_map[? "instance"]) + ") "
            + inst_exists_str);
    }

    return count;
}
