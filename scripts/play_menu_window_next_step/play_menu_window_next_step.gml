function play_menu_window_next_step() {
    var play_window = play_menu_window;
    var world = play_menu_window.world;

    // GAMEMODE AND WORLD
    var gm_id = play_window.gamemode_picker.cur_item_id;
    var gm = DB.gamemodes[? gm_id];

    // GAMEMODE
    var gamemode = instance_create(0,0, gamemode_obj);

    gamemode.mode = gm_id;
    gamemode.name = gm[? "name"];
    gamemode.is_campaign = gm[? "is_campaign"];
    gamemode.is_coop = gm[? "is_coop"];
    gamemode.is_deathmatch = gm[? "is_deathmatch"];
    gamemode.team_based = gm[? "team_based"];

    with(gamemode)
    {
        levels_load_config(gm[? "base_level_config"]);
    }

    if(gamemode.is_campaign)
    {
        DB.player_num = 0;
    }

    // WORLD
    world.current_place = world.places[| play_window.place_picker.cur_item];
    gamemode.world = world;

    gamemode.arena_name = world.current_place.name;
    gamemode.single_cam = world.current_place.single_cam;

    gamemode.tournament_length = 1;

    if(gamemode.is_campaign)
    {
        gamemode.tournament_length = ds_list_size(world.places) - play_window.place_picker.cur_item;
    }

    gamemode.matches_remaining = gamemode.tournament_length;
    gamemode.random_place_order = false;

    // MODS
    ds_map_copy(gamemode.custom_mods, play_window.gmmod_customs);
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

    close_frame(mod_tooltip_window);
    close_frame(play_menu_window);

    add_frame(player_setup_window);
}
