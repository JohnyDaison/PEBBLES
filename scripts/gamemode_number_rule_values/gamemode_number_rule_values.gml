function gamemode_number_rule_values(rule_id, default_value, min_value, max_value, value_step) {
    var gmRule = DB.gamemode_rules[? rule_id];
    
    gmRule[? "default_value"] = default_value;
    gmRule[? "min_value"] = min_value;
    gmRule[? "max_value"] = max_value;
    gmRule[? "value_step"] = value_step;
}