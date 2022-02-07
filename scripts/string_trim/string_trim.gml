function string_trim(str) {
    while (string_char_at(str, 1) == " ") {
        str = string_copy(str, 2, string_length(str));
    }
    
    while (string_char_at(str, string_length(str)) == " ") {
        str = string_copy(str, 1, string_length(str) - 1);
    }
    
    return str;
}