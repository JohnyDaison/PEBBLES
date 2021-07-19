function play_menu_window_start_game() {
    var gm_pane = play_menu_window.gamemode_pane;
    var players_pane = play_menu_window.players_pane;
    var player_panes_map = play_menu_window.player_panes_map;
    var world = play_menu_window.world;


    // GAMEMODE AND WORLD
    var gm_id = gm_pane.gamemode_picker.cur_item_id;
    var gm = DB.gamemodes[? gm_id];

    // GAMEMODE
    var gamemode = instance_create(0,0, gm[? "type"]);

    gamemode.mode = gm_id;
    gamemode.name = gm[? "name"];
    gamemode.is_coop = gm[? "is_coop"];

    with(gamemode)
    {
        levels_load_config(gm[? "base_level_config"]);
    }

    if(gamemode.object_index == campaign_obj)
    {
        DB.player_num = 0;
    }

    // WORLD
    world.current_place = world.places[| gm_pane.place_picker.cur_item];
    gamemode.world = world;

    gamemode.arena_name = world.current_place.name;
    gamemode.single_cam = world.current_place.single_cam;

    gamemode.tournament_length = 1;

    if(gamemode.object_index == campaign_obj)
    {
        gamemode.tournament_length = ds_list_size(world.places) - gm_pane.place_picker.cur_item;
    }

    gamemode.matches_remaining = gamemode.tournament_length;
    gamemode.random_place_order = false;


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


    // MODS
    ds_map_copy(gamemode.custom_mods, gm_pane.gmmod_customs);
    mods_update_state(gm_id, world.current_place, gamemode.custom_mods, gamemode.mods_state);


    // LIMITS
    var i, limit_id, gm_limits = gm[? "limits"];

    for(i=0; i<DB.limit_count; i++)
    {
        limit_id = DB.limit_ids[| i];
        
        if(!is_undefined(gm_limits[? limit_id]))
        {
            gamemode.limit_active[? limit_id] = true;
            gamemode.limits[? limit_id] = gm_limits[? limit_id];
        }
        else
        {
            gamemode.limit_active[? limit_id] = false;
        }
    }


    script_execute(gm[? "start_script"]);

    close_frame(play_menu_window);

    room_goto(world.current_place.room_id);
}
