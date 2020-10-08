if(!lost_control && !other.collected)
{
    var added = add_to_inventory(other.id);
    if(added > 0)
        increase_stat(my_player, "sprays_collected", added, false);
}

