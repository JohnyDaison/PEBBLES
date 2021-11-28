function goto_playmenu() {
    while(instance_exists(empty_frame))
    {
        close_frame(empty_frame);
    }

    add_frame(play_menu_window)
}
