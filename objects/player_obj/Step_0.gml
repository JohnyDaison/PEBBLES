/// @description COLOR INFO
if(instance_exists(my_guy) && instance_exists(my_guy.control_obj)) {
    var player = id;
    
    with(my_guy) {
        if(controlcheck(control_method, pressed, colorinfo)) {
            with(player) {
                display_color_info = !display_color_info;
            }
        }
    }
} else {
    display_color_info = false;
}

if(display_color_info && !instance_exists(color_info)) {
    color_info = add_player_overlay(color_info_overlay, id);
}

if(!display_color_info && instance_exists(color_info)) {
    close_frame(color_info);
}