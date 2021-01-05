function my_string_format(val, total, dec) {

    var str = string_replace_all(string_format(val, total, dec), " ", "0");

    return str;
}
