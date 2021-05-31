/// @description  UNPAUSE
if(paused && has_unpaused)
{
    paused = false;
    surface_free(singleton_obj.paused_surface);
    singleton_obj.paused_surface = noone;
    
    var count = ds_list_size(were_persistent);
    for(var i=0; i<count; i++)
    {
        (were_persistent[| i]).persistent = true;   
    }
    ds_list_clear(were_persistent);
    
    room_persistent = false;
    singleton_obj.paused_room = noone;
    has_unpaused = false;
    
    game_set_speed(singleton_obj.game_speed, gamespeed_fps);
}

