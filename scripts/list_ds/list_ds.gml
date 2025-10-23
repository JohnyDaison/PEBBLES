function list_ds() {
    var count = ds_list_size(DB.ds_registry);

    for (var i = 0; i < count; i++) {
        var entry = DB.ds_registry[| i];
        var typeOfType = typeof (entry.type);
        var ds_exists_str = "ghost", inst_exists_str = "dead";

        if (typeOfType == "number" && ds_exists(entry.id, entry.type)) {
            ds_exists_str = "exists";
        }

        if (instance_exists(entry.instance)) {
            inst_exists_str = "exists";
        }


        my_console_write(
            entry.name + " (" + string(entry.type) + ":" + string(entry.id) + ") "
            + ds_exists_str + " on "
            + entry.objectName + " (" + string(entry.instance) + ") "
            + inst_exists_str);
    }

    return count;
}
