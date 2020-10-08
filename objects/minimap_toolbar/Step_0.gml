action_inherited();
if(cursor_obj.x > minimap_left && cursor_obj.x < minimap_right
&& cursor_obj.y > minimap_top && cursor_obj.y < minimap_bottom
&& DB.mouse_has_moved)
{
    if(mouse_check_button_pressed(mb_left))
    {
        editor_camera.x = 32 * (cursor_obj.x - (minimap_left + (minimap_width/2 - minimap_view_width/2)) + (__view_get( e__VW.XView, 0 )/32)*mini_block_size)/mini_block_size;
        editor_camera.y = 32 * (cursor_obj.y - (minimap_top + (minimap_height/2 - minimap_view_height/2))  + (__view_get( e__VW.YView, 0 )/32)*mini_block_size)/mini_block_size;
        cursor_obj.x = minimap_left + minimap_width/2;
        cursor_obj.y = minimap_top + minimap_height/2;
        with(cursor_obj)
        {
            event_perform(ev_other,ev_user0);
        }
    }
}

