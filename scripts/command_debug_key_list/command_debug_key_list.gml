/// @param {String} search
function command_debug_key_list(search = "") {
    var count = ds_list_size(DB.debug_keys_list);

    search = string_lower(search);

    for (var i = 0; i < count; i++) {
        var item = DB.debug_keys_list[| i];
        var str = item.input;

        while (string_length(str) < 20) {
            str += " ";
        }

        var line = str + " : " + item.label;

        if (search == "" || string_pos(search, string_lower(line)) > 0) {
            my_console_write(line);
        }
    }

    return count;
}
