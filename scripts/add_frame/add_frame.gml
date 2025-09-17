/// @param {Asset.GMObject} new_frame
/// @returns {Id.Instance}
function add_frame(new_frame) {
    if (new_frame == noone) {
        show_debug_message("\"noone\" is not a frame");
        return noone;
    }
    else if (object_is_ancestor(new_frame, empty_frame)) {
        var frame_id = instance_create(0, 0, new_frame);
        var name = object_get_name(new_frame);
        if (!instance_exists(frame_id)) {
            show_debug_message("Frame \"" + name + "\" rejected.");
            return noone;
        }

        show_debug_message("Adding frame \"" + name + "\"(" + string(frame_id) + ")");
        gui_clear_focus(frame_manager);
        ds_list_add(frame_manager.gui_content, frame_id);
        frame_id.gui_parent = frame_manager.id;

        with (empty_frame) {
            alarm[0] = 3;
        }
        with (frame_id) {
            gui_get_focus();
        }

        return frame_id;
    }
    else if (object_exists(new_frame)) {
        show_debug_message("\"" + object_get_name(new_frame) + "\"(" + string(new_frame) + ") is not a frame");
        return noone;
    }
    else {
        show_debug_message(string(new_frame) + " is not an object");
        return noone;
    }
}
