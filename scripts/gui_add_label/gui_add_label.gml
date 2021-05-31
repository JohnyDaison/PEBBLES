/// @param x
/// @param y
/// @param text
function gui_add_label(xx, yy, text) {
    var label = gui_child_init(xx + self.eloffset_x, yy + self.eloffset_y, gui_label);
    label.text = text;
    
    frame_manager.window_log_str += text + "\t";

    return label;
}
