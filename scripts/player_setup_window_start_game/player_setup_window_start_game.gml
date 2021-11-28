function player_setup_window_start_game() {
    var gamemode = gamemode_obj.id;
    var gm = DB.gamemodes[? gamemode_obj.mode];
    var players_pane = player_setup_window.players_pane;
    var player_panes_map = player_setup_window.player_panes_map;
    
    // PLAYERS
    gamemode.player_count = players_pane.playernum_input.value;
    gamemode.human_player_count = 0;
    var gamepad_index = 0, pl_num, player_pane;

    for(pl_num = 1; pl_num <= gamemode.player_count; pl_num++)
    {
        var player = instance_create(0,0,player_obj);
        player.number = pl_num;
    
        if(gamemode.is_coop)
        {
            player.team_number = 1;
        } 
        else if(gamemode.mode == "volleyball")
        {
            player.team_number = player.number mod 2;
            if(player.team_number == 0)
            {
                player.team_number = 2;
            }
        } 
        else
        {
            player.team_number = player.number mod 2;
            if(player.team_number == 0)
            {
                player.team_number = 2;
            }
        }
    
        if(player.team_number > gamemode.team_count)
        {
            gamemode.team_count = player.team_number;
        }
    
        player_pane = player_panes_map[? pl_num];
    
        if(!is_undefined(player_pane))
        {
            player.name = player_pane.name_input.text;
            player.flag = DB.player_flags[| player_pane.flag_input.value];
            player.icon = DB.battlefeed_icon_map[? player.flag];
            player.handicaps[? "min_damage"] = player_pane.handicap_input.value/10;
            player.control_set = player_pane.control_dropdown.value_id;
            if(player.control_set == gamepad)
            {
                player.control_index = gamepad_index++;
            }
            player.is_cpu = (player.control_set == cpu_control_set);
            player.cpu_difficulty = player_pane.cpudiff_input.value/100;
        }
        else
        {
            var teammate = noone;
            with(player_obj)
            {
                if(id != player.id && team_number == player.team_number)
                {
                    teammate = id;
                }
            }
        
            if(teammate != noone)
            {
                player.name = "Player " + string(player.number);
                player.flag = teammate.flag;
                player.icon = DB.battlefeed_icon_map[? player.flag];
                player.handicaps[? "min_damage"] = teammate.handicaps[? "min_damage"];
                //player.control_set = teammate.control_set;
                player.control_set = cpu_control_set;
                if(player.control_set == gamepad)
                {
                    player.control_index = gamepad_index++;
                }
                player.is_cpu = (player.control_set == cpu_control_set);
                player.cpu_difficulty = teammate.cpu_difficulty;
            }
        }
    
        if(player.is_cpu)
        {
            gamemode.cpu_player_exists = true;
        }
        else
        {
            gamemode.human_player_count++;
            gamemode.last_human_player = player.number;
        }

        gamemode.players[? pl_num] = player;
    }
    
    script_execute(gm[? "start_script"]);
    gamemode.game_started = true;

    close_frame(player_setup_window);

    room_goto(gamemode.world.current_place.room_id);
}