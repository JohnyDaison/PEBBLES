/// @param {Real} player_number
/// @returns {Real}
function player_quests_recheck_command(player_number) {
    if (!instance_exists(gamemode_obj)) {
        return 0;
    }

    var player = gamemode_obj.players[? player_number];

    if (is_undefined(player)) {
        return 0;
    }

    return player_quests_recheck(player);
}
