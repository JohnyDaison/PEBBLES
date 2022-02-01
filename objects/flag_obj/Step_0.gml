event_inherited();

if (collected && my_player.team_number == my_team_number) {
    var flag = id;
    with(my_guy) {
        take_from_inventory(flag);
    }
    instance_destroy();
    increase_stat(my_player, "flags_returned", 1, false);
}