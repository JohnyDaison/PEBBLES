/// @param {String} prop
/// @param {String} valueInput
function find_holders(prop = "", valueInput = "") {
    var type_str = "string";
    var value = valueInput;
    var applyFilter = false;

    if (prop != "" && valueInput != "") {
        applyFilter = true;

        if (is_string_number(valueInput)) {
            value = parse_stringvalue("assetornumber", valueInput);
            type_str = "asset id or number";
        } else {
            var obj = parse_stringvalue("object", valueInput);

            if (obj != noone) {
                value = obj;
                type_str = "object";
            }
        }
    }

    if (applyFilter) {
        my_console_write("filter: " + prop + " = " + string(value) + " (" + type_str + ")");
    }

    var count = 0;

    with (data_holder_obj) {
        if (applyFilter && self.transform_memory[? prop] != value) {
            continue;
        }
        
        var idStr = string(self.id);
        var nameStr = object_get_name(self.transform_memory[? "object_index"]);
        var chunkgridPositionStr = string(self.chunkgrid_x) + ", " + string(self.chunkgrid_y);
        var positionStr = string(self.x) + "," + string(self.y);

        my_console_write(idStr + "(" + nameStr + ")@[" + chunkgridPositionStr + "]: [" + positionStr + "]");

        count++;
    }

    return count;
}
