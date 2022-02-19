function mod_forced_value_update(gmmod, value, new_value) {
    if(is_undefined(new_value)) {
        return value;
    }
    
    if (number_mod_any_value(gmmod, new_value)) {
        if (is_undefined(value) || (is_bool(value) && !value)) {
            value = new_value;
        }
    } else {
        value = new_value;
    }
    
    return value;
}