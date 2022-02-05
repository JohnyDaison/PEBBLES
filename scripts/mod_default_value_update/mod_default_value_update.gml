function mod_default_value_update(gmmod, value, new_value) {
    if(is_undefined(new_value)) {
        return value;
    }
    
    if (number_mod_any_value(gmmod, new_value)) {
        if (is_undefined(value)) {
            value = gmmod[? "default_value"];
        }
    } else {
        value = new_value;
    }
    
    return value;
}