function show_player_levels(player_number) {
    if(!instance_exists(gamemode_obj)) {
        return 0;
    }

    var player = gamemode_obj.players[? player_number];

    if(is_undefined(player)) {
        return 0;
    }

    var i,key,count = ds_list_size(DB.level_list);

    for(i=0; i<count; i++) {
        key = DB.level_list[| i];
        
        my_console_write(key + " " + string(player.levels_roomstart[? key]) + " " + string(player.levels[? key]));
    }
}
