/// @description gui_add_button(x, y, text, script, [repeater]);
/// @function gui_add_button
/// @param x
/// @param y
/// @param text
/// @param script
/// @param {bool} [repeater]
function gui_add_button() {
    var xx, yy, new_text, new_script, repeater, button;

    xx = argument[0];
    yy = argument[1];
    new_text = argument[2];
    new_script = argument[3];

    repeater = false;
    if(argument_count > 4)
    {
        repeater = argument[4];
    }

    button = gui_child_init(xx+self.eloffset_x, yy+self.eloffset_y, gui_button);
    button.text = new_text;

    // WIDTH ADJUSTMENT
    my_draw_set_font(button.font);
    var text_width = string_width(button.text);

    while(text_width > button.width - 32)
    {
        button.width += 32; 
    }

    if(repeater)
    {
        button.ondown_script = new_script;
        button.onrepeat_script = new_script; 
    }
    else
    {
        button.onup_script = new_script;
    } 
    button.repeater = repeater;

    return button;
}
