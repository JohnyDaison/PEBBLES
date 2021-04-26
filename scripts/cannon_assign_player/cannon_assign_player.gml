function cannon_assign_player(cannon, player) {
    if(!instance_exists(cannon) || !instance_exists(player)) {
        return;
    }
    
    if(cannon.my_player != player) {
        cannon_unassign_player(cannon);
    }
    
    var index = ds_list_find_index(player.my_cannons, cannon.id);
    
    if(index == -1) {
        ds_list_add(player.my_cannons, cannon.id);
    }
    
    cannon.my_player = player;
    cannon.my_guy = player.my_guy;
}
