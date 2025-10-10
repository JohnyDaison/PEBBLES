/// @param {String} newModeStr
function console_mode_command(newModeStr = "") {

    if (newModeStr != "") {
        var newMode = array_get_index(DB.consoleModeStrings, newModeStr);

        if (!is_undefined(DB.console_modes[? newMode])) {
            DB.console_mode = newMode;
        }
    }

    return DB.consoleModeStrings[DB.console_mode];
}
