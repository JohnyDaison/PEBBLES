function goto_playmenu() {
    while(instance_exists(empty_frame))
    {
        close_frame(empty_frame);
    }
    
    frame_manager.menu_window = play_menu_window;
    
    if(room != mainmenu)
    {
        room_goto(mainmenu);
    }
    else
    {
        add_frame(play_menu_window)
    }
}
