function gui_add_button(xx, yy, text, handler, repeater = false) {
    var button = gui_child_init(xx+self.eloffset_x, yy+self.eloffset_y, gui_button);
    button.text = text;
    button.repeater = repeater;

    // WIDTH ADJUSTMENT
    my_draw_set_font(button.font);
    var text_width = string_width(button.text);

    while(text_width > button.width - 32)
    {
        button.width += 32;
    }
    
    if (is_undefined(handler)) {
        return button;
    }

    // HANDLER
    if (is_method(handler)) {
        if (repeater) {
            button.ondown_function = handler;
            button.onrepeat_function = handler;
        } else {
            button.onup_function = handler;
        }
    } else if (script_exists(handler)) {
        if (repeater) {
            button.ondown_script = handler;
            button.onrepeat_script = handler;
        } else {
            button.onup_script = handler;
        }
    }
    
    return button;
}
