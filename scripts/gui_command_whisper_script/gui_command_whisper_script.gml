function gui_command_whisper_script() {
    var list_picker = gui_parent;
    var command_input = list_picker.gui_parent;
    
    var command = items[| cur_item];
    
    if(!is_undefined(command)) {
        command_input.text = command;
        keyboard_string = command;
    }
    
    if (list_picker.visible) {
        gui_hide_element(list_picker);
    }
}