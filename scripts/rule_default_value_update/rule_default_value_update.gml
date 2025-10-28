function rule_default_value_update(gmRule, value, new_value) {
    if(is_undefined(new_value)) {
        return value;
    }
    
    if (number_rule_any_value(gmRule, new_value)) {
        if (is_undefined(value)) {
            value = gmRule[? "default_value"];
        }
    } else {
        value = new_value;
    }
    
    return value;
}