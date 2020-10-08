if(!lost_control && !other.collected && holographic == other.holographic
&& (other.for_player == -1 || other.for_player == my_player.number))
{
    var added = add_to_inventory(other.id);
    if(added > 0)
        increase_stat(my_player, "grenades_collected", added, false);
}

