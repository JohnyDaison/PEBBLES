function set_single_value(object, variable, value) {
    var count = 0;

    with(object) {
        if (variable_instance_exists(id, variable)) {
           variable_instance_set(id, variable, value);
           count++;
        }
    }
    
    return string(count) + " instances affected";
}