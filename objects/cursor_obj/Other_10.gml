/// @description  SET MOUSE POSITION BASED ON MY x AND y

if(singleton_obj.fullscreen_set)
{
    display_mouse_set(x*display_get_width() / singleton_obj.current_width,
                      y*display_get_height() / singleton_obj.current_height);
}
else
{
    window_mouse_set(x,y);
}

