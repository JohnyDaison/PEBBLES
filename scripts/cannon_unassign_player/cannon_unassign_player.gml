/// @param {Id.Instance} cannon
function cannon_unassign_player(cannon) {
    if (!instance_exists(cannon) || !instance_exists(cannon.my_player)) {
        return;
    }

    var index = ds_list_find_index(cannon.my_player.my_cannons, cannon.id);

    if (index != -1) {
        ds_list_delete(cannon.my_player.my_cannons, index);
    }
}
