function gui_get_focus() {
    var force = false;
    if (argument_count > 0) {
        force = argument[0];
    }

    show_debug_message("getting focus");
    show_debug_message("id: " + string(id));
    if (object_is_ancestor(self.object_index, gui_object) && instance_exists(gui_parent)) {
        var child = id;

        show_debug_message("parent exists");
        with (gui_parent) {
            if (object_index == frame_manager && object_is_ancestor(other.object_index, empty_frame)) {
                show_debug_message("focusing frame " + string(child));
                if (focused_child == child) {
                    other.focused = true;
                    return true;
                }
                else if (gui_clear_focus(focused_child, force)) {
                    self.content_focused = ds_list_find_index(self.gui_content, child);
                    self.focused_child = child;

                    other.focused = true;
                    self.focused = true;

                    return true;
                }
                else
                    return false;
            }
            else if (object_is_ancestor(object_index, empty_frame)) {
                if (!focused) {
                    show_debug_message("parent is unfocused frame");
                    if (force) {
                        gui_get_focus(force);
                    } else {
                        return false;
                    }
                }

                if (self.focused_child != child) {
                    show_debug_message("parent is focused frame but not on me");
                    if (gui_clear_focus(self.focused_child)) {
                        self.content_focused = ds_list_find_index(self.gui_content, child);
                        self.focused_child = child;
                        other.focused = true;
                        return true;
                    }
                    else
                        return false;
                }
                else {
                    show_debug_message("parent frame already focused on me");
                    other.focused = true;
                    return true;
                }
            }
            else {
                if (!focused) //!other.focused
                {
                    show_debug_message("parent is not focused");
                    if (gui_get_focus(force)) {
                        self.content_focused = ds_list_find_index(self.gui_content, child);
                        self.focused_child = child;
                        other.focused = true;
                        self.focused = true;
                        return true;
                    }
                    else {
                        show_debug_message("parent could not get focused");
                        return false;
                    }
                }
                else {
                    if (self.focused_child != child) {
                        show_debug_message("parent is focused but not on me");

                        if (gui_clear_focus(self.focused_child)) {
                            self.content_focused = ds_list_find_index(self.gui_content, child);
                            self.focused_child = child;
                            other.focused = true;
                            self.focused = true;
                            return true;
                        }
                        else
                            return false;
                    }
                    else {
                        show_debug_message("parent already focused on me");
                        other.focused = true;
                        return true;
                    }
                }
            }
        }
    }
}
