function number_rule_any_value(gmRule, new_value) {
    return gmRule.type == "number" && is_bool(new_value) && new_value;
}