/// @param {String} str
/// @returns {Bool}
function is_string_number(str) {
    var length = string_length(str);
    var ord_0 = ord("0");
    var ord_9 = ord("9");

    var str_parts = ds_list_create();
    string_explode(str, ".", str_parts);

    var part_count = ds_list_size(str_parts);

    if (part_count == 0 || part_count > 2) {
        return false;
    }

    var first_part = str_parts[| 0];
    var first_char = string_char_at(first_part, 0);

    if (first_char == "-") {
        first_part = string_copy(first_part, 2, length);
    }

    var first_part_length = string_length(first_part);
    
    if (first_part_length == 0) {
        return false;
    }

    for (var chr_i = 1; chr_i <= first_part_length; chr_i++) {
        var chr_ord = string_ord_at(first_part, chr_i);

        if (chr_ord < ord_0 || chr_ord > ord_9) {
            return false;
        }
    }

    return true;
}
