function player_quest_start_command(player_number, quest_id, context_id, category) {
    if(!instance_exists(gamemode_obj)) {
        return 0;
    }

    var player = gamemode_obj.players[? player_number];

    if(is_undefined(player)) {
        return 0;
    }

    return player_receive_quest(player, quest_id, context_id, category);
}
