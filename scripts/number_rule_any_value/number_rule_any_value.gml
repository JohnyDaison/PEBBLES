function number_rule_any_value(gmmod, new_value) {
    return gmmod[? "type"] == "number" && is_bool(new_value) && new_value;
}