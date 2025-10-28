function gamemode_number_rule_values(rule_id, default_value, min_value, max_value, value_step) {
    var gmmod = DB.gamemode_rules[? rule_id];
    
    gmmod[? "default_value"] = default_value;
    gmmod[? "min_value"] = min_value;
    gmmod[? "max_value"] = max_value;
    gmmod[? "value_step"] = value_step;
}