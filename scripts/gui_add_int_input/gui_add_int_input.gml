function gui_add_int_input(xx, yy, default_value, min_value, max_value) {
    var new_sign, input;

    new_sign = sign(default_value);

    input = gui_child_init(xx+self.eloffset_x,yy+self.eloffset_y,gui_int_input);
    input.value = default_value;
    input.last_value = input.value;
    if(new_sign == -1) 
        input.cur_sign = new_sign;
    input.min_value = min_value;
    input.max_value = max_value;

    return input;
}
