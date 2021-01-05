/// @description gui_add_checkbox(xx, yy, [checked])
/// @function gui_add_checkbox
/// @param xx
/// @param yy
/// @param [checked]
function gui_add_checkbox(xx, yy) {
    var ii, checked;

    ii = gui_child_init(xx + self.eloffset_x, yy + self.eloffset_y, gui_checkbox);

    if(argument_count > 2)
    {
        checked = argument[2];
        ii.checked = checked;
    }

    return ii;
}
