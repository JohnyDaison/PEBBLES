/// @param {Asset.GMObject|Id.Instance} object
/// @param {String} prop
function get_value_command(object = noone, prop = undefined) {
    // if no object specified, show objectmap keys
    if (object == noone) {
        var key = ds_map_find_first(DB.objectmap);

        while (!is_undefined(key)) {
            my_console_write(string(key));

            key = ds_map_find_next(DB.objectmap, key);
        }

        return 0;
    }

    // no instances
    if (!instance_exists(object)) {
        my_console_write("No instance found.");
        return 0;
    }

    // if prop is undefined, show list of props
    if (prop == undefined) {
        var instance = object.id;

        var names = variable_instance_get_names(instance);
        array_sort(names, true);
        var count = variable_instance_names_count(instance);

        for (var i = 0; i < count; i++) {
            var name = names[i];
            my_console_write(name);
        }

        return 0;
    }

    // show value of prop for each of instances of given object
    var count = 0;

    with (object) {
        var result = "";
        var prop_exists = variable_instance_exists(self.id, prop);

        if (prop_exists) {
            result = variable_instance_get(self.id, prop);

            if (is_string(result)) {
                result = "\"" + result + "\"";
            } else {
                result = string(result);
            }
        }

        my_console_write(string(self.id) + " " + result);
        count++;
    }

    return count;
}
