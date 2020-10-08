if(!lost_control && !other.collected && holographic == other.holographic
&& (other.for_player == -1 || other.for_player == my_player.number))
{
    other.my_guy = id;
    with(other)
    {
        event_perform(ev_other, ev_user1);
        increase_stat(other.my_player, "batteries_collected", stack_size, false);
        instance_destroy();
    }
}

