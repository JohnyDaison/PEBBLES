function goto_mainmenu() {
    /*
    // bad code, does not let the objects in the paused room destroy ds_* properties
        -> would it work just by conversion of Destroy to Clean Up ? No, not enough.
    
    if(instance_exists(singleton_obj.paused_room))
    {
        room_set_persistent(singleton_obj.paused_room, false);
        singleton_obj.paused_room = noone;
    }
    singleton_obj.paused = false;
    singleton_obj.has_unpaused = false;
    */
    
    while(instance_exists(empty_frame))
    {
        close_frame(empty_frame);
    }
    
    with(world_obj)
    {
        instance_destroy();
    }

    with(gamemode_obj)
    {
        instance_destroy();
    }
    
    if(room != mainmenu)
    {
        room_goto(mainmenu);
    }
    else
    {
        add_frame(main_menu_window);
    }
}
