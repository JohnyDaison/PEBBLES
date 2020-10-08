if(!lost_control && !other.collected && holographic == other.holographic
&& (other.for_player == -1 || other.for_player == my_player.number))
{
    if(damage > min_damage)
    {
        other.my_guy = id;
        with(other)
        {
            event_perform(ev_other, ev_user1);
            instance_destroy();
        }
    }
}

