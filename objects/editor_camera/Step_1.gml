if (on) {
    var viewCamera = view_get_camera(view);
    var half_wview = camera_get_view_width(viewCamera) / 2;
    var half_hview = camera_get_view_height(viewCamera) / 2;

    if (pan_mode) {
        var mouse_down = mouse_check_button(mb_left);
        
        if (mouse_down) {
            if (!dragging) {
                dragging = true;
                orig_x = x;
                orig_y = y;
                orig_mouse_x = cursor_obj.x;
                orig_mouse_y = cursor_obj.y;
            }
            else {
                x = orig_x - (cursor_obj.x - orig_mouse_x);
                y = orig_y - (cursor_obj.y - orig_mouse_y);
                x = max(half_wview,min(x,place_obj.x+place_obj.width +place_obj.margin -half_wview));
                y = max(half_hview,min(y,place_obj.y+place_obj.height +place_obj.margin -half_hview));
            }
        }
        
        if (dragging && !mouse_down) {
            dragging = false;
        }
    }
    
    if (!inited_view) {
        inited_view = true;
        update_display();
    }

    camera_set_view_pos(viewCamera,
        x - camera_get_view_width(viewCamera) / 2,
        y - camera_get_view_height(viewCamera) / 2
    );
}
