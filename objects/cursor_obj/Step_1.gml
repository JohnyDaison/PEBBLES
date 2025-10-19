var cursor = self.id;
var view_drag = false;
if (instance_exists(editor_camera) && editor_camera.dragging) {
    view_drag = true;
}

if (singleton_obj.fullscreen_set) {
    self.x = display_mouse_get_x() / display_get_width() * display_get_gui_width();
    self.y = display_mouse_get_y() / display_get_height() * display_get_gui_height();
} else {
    self.x = window_mouse_get_x();
    self.y = window_mouse_get_y();
}

if (!view_drag) {
    if (view_enabled) {
        var zoom = 1;

        if (instance_exists(main_camera_obj)) {
            zoom = main_camera_obj.zoom_level;
        }

        if (view_get_visible(0)) {
            var viewCamera = view_get_camera(0);
            var viewX = camera_get_view_x(viewCamera);
            var viewY = camera_get_view_y(viewCamera);

            self.room_x = viewX + x / zoom;
            self.room_y = viewY + y / zoom;
        } else {
            var view_found = false;
            var view = 1;

            while (!view_found && view_get_visible(view)) {
                var viewCamera = view_get_camera(view);
                var viewX = camera_get_view_x(viewCamera);
                var viewY = camera_get_view_y(viewCamera);

                var cursorPortX = x - view_get_xport(view);
                var cursorPortY = y - view_get_yport(view);
                var portWidth = view_get_wport(view);
                var portHeight = view_get_hport(view);

                if (cursorPortX >= 0 && cursorPortX < portWidth && cursorPortY >= 0 && cursorPortY < portHeight) {
                    var cam = main_camera_obj.cameras[? view];

                    self.room_x = viewX + cursorPortX / cam.zoom_level;
                    self.room_y = viewY + cursorPortY / cam.zoom_level;

                    view_found = true;
                }
                else {
                    view++;
                }
            }
        }
    }
    else {
        self.room_x = mouse_x;
        self.room_y = mouse_y;
    }
}

// CHECK MOUSE
if (!DB.mouse_has_moved) {
    if (self.x != self.last_x || self.y != self.last_y) {
        DB.mouse_has_moved = true;
    }
}

self.last_x = x;
self.last_y = y;

if (room == level_editor) {
    if (DB.mouse_has_moved && keyboard_check_pressed(vk_control)) {
        self.old_tool = self.active_tool.object_index;
        tool_activate(self.ctrl_tool);
    }

    if (DB.mouse_has_moved && keyboard_check_released(vk_control)) {
        tool_deactivate(self.ctrl_tool);
        tool_activate(self.old_tool);
    }
}

if (DB.mouse_has_moved && mouse_check_button_pressed(mb_any)) {
    singleton_obj.last_gui_device = mouse;
    var focused_frame = frame_manager.focused_child;
    var focused_is_modal = false;
    var focused_name = "noone";
    var focus_found = false;

    if (instance_exists(focused_frame)) {
        focused_is_modal = focused_frame.modal;
        focused_name = object_get_name(focused_frame.object_index);
    }
    show_debug_message("focused frame: " + focused_name);

    var new_frame = noone;
    var new_is_modal = false;
    var new_is_console = false;

    with (empty_frame) {
        if (self.visible
                && self.x <= cursor.x && cursor.x < (self.x + self.width)
                && self.y <= cursor.y && cursor.y < (self.y + self.height)) {
            var name = object_get_name(self.object_index);
            show_debug_message("cursor is in frame " + name);

            var is_console = self.object_index == console_window || self.object_index == watches_window;

            if (!new_is_console && (new_frame == noone || is_console
                || (!focused_is_modal && !new_is_modal) || self.modal)) {
                show_debug_message("frame " + name + " is considered");

                new_frame = self.id;
                new_is_modal = self.modal;
                new_is_console = is_console;
            }
        }
    }

    var force_new = new_is_modal || new_is_console;

    if (instance_exists(focused_frame)) {
        show_debug_message("focused object_index: " + focused_name);

        if (object_is_ancestor(focused_frame.object_index, empty_frame)) {
            if (focused_is_modal && !force_new) {
                focus_found = true;
            }
            else if (object_is_ancestor(focused_frame.object_index, gui_object)) {
                with (focused_frame) {
                    if (self.visible && !focus_found && 
                        self.x <= cursor.x && cursor.x < (self.x + self.width) && 
                        self.y <= cursor.y && cursor.y < (self.y + self.height)) {
                        show_debug_message("cursor is in frame " + focused_name);

                        if (self.focused) {
                            show_debug_message("manager focused on me and I am");
                            focus_found = true;
                        } else {
                            show_debug_message("manager focused on me and I'm not");
                            gui_get_focus();
                            focus_found = true;
                        }
                    }
                }
            }
        }
    }

    if (!focus_found) {
        show_debug_message("focused frame not found, clearing all");
        gui_clear_focus(frame_manager, force_new);
    }
    else if (instance_exists(self.focus) && !self.focus.visible) {
        show_debug_message("focused element invisible, clearing all");
        gui_clear_focus(frame_manager, force_new);
    }

    if (!focus_found && new_frame != noone) {
        with (new_frame) {
            gui_get_focus();
            focus_found = true;
        }
    }

    if (focus_found) {
        show_debug_message("focus found, clearing tools");
        clear_tools();
    }
    else if (instance_exists(self.last_active_tool)) {
        tool_activate(self.last_active_tool);
    }
}
else if (singleton_obj.last_gui_device == mouse) {
    singleton_obj.last_gui_device = -1;
}

if (!instance_exists(self.active_tool)) {
    self.glow_ratio += self.glow_dir * self.glow_step;

    if (self.glow_ratio >= 1 - self.glow_step) {
        self.glow_ratio = 1 - self.glow_step;
        self.glow_dir = -1;
    }

    if (self.glow_ratio <= self.glow_min) {
        self.glow_ratio = self.glow_min;
        self.glow_dir = 1;

        if (!instance_exists(gamemode_obj)) {
            self.my_color = irandom(7);
            self.tint_updated = false;
        }
    }
}
else {
    self.glow_ratio = 0.5;
    self.my_color = g_white;
    self.last_active_tool = self.active_tool.object_index;
}

if (self.tint_updated == false) {
    self.new_tint = DB.colormap[? self.my_color];

    self.tint = merge_color(self.tint, self.new_tint, 1 / 6);

    if (self.tint == self.new_tint) {
        self.tint_updated = true;
    }
}

var focus = noone;
var focus_depth = 20000;

if (DB.mouse_has_moved) {
    with (gui_element) {
        if (self.want_focus && self.visible) {
            if (cursor.x > self.x && cursor.x < (self.x + self.width)
            && cursor.y > self.y && cursor.y < (self.y + self.height)
            && (focus == noone || self.depth < focus_depth)) {
                focus = self.id;
                focus_depth = self.depth;
            }
        }
    }
}

self.focus = focus;
self.focus_depth = focus_depth;