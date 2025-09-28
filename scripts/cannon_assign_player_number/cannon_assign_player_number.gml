/// @param {Id.Instance} cannon
/// @param {Real} player_number
function cannon_assign_player_number(cannon, player_number) {
    var player = gamemode_obj.players[? player_number];

    if (!is_undefined(player)) {
        cannon_assign_player(cannon, player);
    }
}
