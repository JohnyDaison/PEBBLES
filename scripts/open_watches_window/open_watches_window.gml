function open_watches_window(open) {
    if (is_undefined(open)) {
        open = true;
    }
    
    if (open) {
        if (!instance_exists(watches_window)) {
            add_frame(watches_window);
        } else {
            with(watches_window) {
                gui_get_focus(true);
            }
        }
    } else {
        close_frame(watches_window);
    }
}