/// @param {Real} player_number
/// @param {String} quest_id
/// @param {String} context_id
/// @param {String} category
/// @return {Real}
function player_quest_start_command(player_number, quest_id, context_id, category) {
    if (!instance_exists(gamemode_obj)) {
        return 0;
    }

    var player = gamemode_obj.players[? player_number];

    if (is_undefined(player)) {
        return 0;
    }

    var quest_state = player_receive_quest(player, quest_id, context_id, category);

    return is_undefined(quest_state) ? 0 : 1;
}
