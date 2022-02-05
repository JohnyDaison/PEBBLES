function is_number(value) {
    return !is_undefined(value) && is_numeric(value) && !is_bool(value);
}