function do_room_cleanup() {
    with(empty_frame)
    {
        close_frame(id);
    }

    with(game_obj)
    {
        if(cancellable)
        {
            cancelled = true;
            event_perform(ev_other, ev_room_end);
            instance_destroy();
        }
    }
}
