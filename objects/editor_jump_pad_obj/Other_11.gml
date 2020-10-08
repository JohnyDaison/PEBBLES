// OPEN LITTLE config_window WITH INT DIAL AND OK BUTTON
if(!instance_exists(config_window))
{
    config_window = add_frame(jump_pad_config_window);
    config_window.x = cursor_obj.x;
    config_window.y = cursor_obj.y;
    config_window.my_pad = id;
}

