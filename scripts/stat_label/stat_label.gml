/// @param {String} stat
/// @param {Any} value if (type != "") value must be Real
/// @param {String} type valid options: "" , "+" , "-"
/// @return {String}
function stat_label(stat, value = undefined, type = "") {
    var DBindex = ds_list_find_index(DB.stats_display_keys, stat);
    
    if (DBindex == -1 || is_undefined(value)) {
        return "";
    }
    
    var stat_name = DB.stats_display_labels[| DBindex];
    var value_prefix = "";
    
    if ((type == "+" || type == "-")) {
        if (type == "-") {
            value *= -1;
        }

        if (value >= 0) {
            value_prefix = "+";
        }
    }
    
    return stat_name + " " + value_prefix + string(value);
}
