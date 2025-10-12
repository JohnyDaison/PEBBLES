/// @description  GENERATE NAVIGATION

frame_manager.current_frame = self.id;
frame_manager.first_elem = noone;

with (gui_element) {
    //if(!object_is_ancestor(object_index,empty_frame))
    //{
    if (self.parent_frame == frame_manager.current_frame && self.want_focus) {
        self.closest_right = noone;
        self.closest_left = noone;

        if (self.enabled) {
            frame_manager.first_elem = self.id;
        }

        with (gui_element) {
            if (self.parent_frame == frame_manager.current_frame && self.want_focus && abs(self.y - other.y) <= 16 && self.id != other.id) {
                if ((self.x - other.x) > 0) {
                    if (!instance_exists(other.closest_right)) {
                        other.closest_right = self.id;
                    }
                    if ((other.closest_right.x - self.x) > 0) {
                        other.closest_right = self.id;
                    }
                }
                if ((self.x - other.x) < 0) {
                    if (!instance_exists(other.closest_left)) {
                        other.closest_left = self.id;
                    }
                    if ((other.closest_left.x - self.x) < 0) {
                        other.closest_left = self.id;
                    }
                }
            }
        }

        if (!instance_exists(self.right_hand_object)) {
            self.right_hand_object = self.closest_right;
        }
        if (!instance_exists(self.left_hand_object)) {
            self.left_hand_object = self.closest_left;
        }
    }
    //}
}

if (instance_exists(frame_manager.first_elem)) {
    with (frame_manager.first_elem) {
        gui_get_focus();
    }
    show_debug_message("first focused");
}
