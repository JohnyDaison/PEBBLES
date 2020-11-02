if(instance_exists(my_player))
{
    my_camera = my_player.my_camera;
    if(instance_exists(my_camera))
    {
        view_offset = get_view_offset(my_camera.view);
        
        x = view_offset.x + (view_get_wport(my_camera.view) / 2) - (width / 2);
        y = view_offset.y + view_get_hport(my_camera.view) - (height + abi_panel_height + 2 * margin);
    }
}