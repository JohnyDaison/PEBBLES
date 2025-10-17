/// @param {String} search_str
function console_help_script(search_str = "") {
    my_console_write("Note: An 'object' parameter can usually be passed either:");
    my_console_write("        * object name to affect instances of it and descendants");
    my_console_write("        * instance id to target specific instance");
    console_divider_level("", 3);

    var list = DB.console_modes[? DB.console_mode];
    var count = ds_list_size(list);
    var filtered_count = 0;

    // column offsets
    var name_start_index = 4;
    var arguments_start_index = 25;
    var help_start_index = 50;

    for (var i = -1; i < count; i++) {
        var name = "", script = undefined, script_str = "";

        // decide name and script
        if (i == -1) {
            name = "Command";
        }
        else {
            name = list[| i];

            if (ds_list_find_index(DB.console_secrets, name) != -1)
                continue;

            if (search_str != "" && string_pos(search_str, name) == 0)
                continue;

            script = DB.console_scripts[? name];
        }

        // line number
        if (i >= 0) {
            script_str = string(i);
        }

        // spacing before name
        while (string_length(script_str) < name_start_index) {
            script_str += " ";
        }

        // name
        script_str += " " + name;

        // spacing before arguments
        while (string_length(script_str) < arguments_start_index) {
            script_str += " ";
        }

        // arguments
        if (i == -1) {
            script_str += " Arguments";
        }
        else {
            var arg_i = 1;
            var cur_arg = script[? "arg" + string(arg_i)];
            var optional = false;

            while (!is_undefined(cur_arg)) {
                script_str += " ";

                if (arg_i > script[? "min_args"]) {
                    script_str += "[";
                    optional = true;
                }

                script_str += cur_arg;

                arg_i += 1;
                cur_arg = script[? "arg" + string(arg_i)];

                if (optional) {
                    script_str += "]";
                }
            }
        }

        // spacing before help text
        while (string_length(script_str) < help_start_index) {
            script_str += " ";
        }

        // help text
        if (i == -1) {
            script_str += " Help";
        }
        else {
            script_str += " " + script[? "help_text"];
        }

        // output line to console
        my_console_write(script_str);

        // underline heading
        if (i == -1) {
            console_divider_level("-", 3);
        }

        if (i >= 0) {
            filtered_count++;
        }
    }

    return filtered_count;
}
