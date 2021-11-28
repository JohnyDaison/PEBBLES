function play_menu_window_next_step() {
    var gm_pane = play_menu_window.gamemode_pane;
    var world = play_menu_window.world;

    // GAMEMODE AND WORLD
    var gm_id = gm_pane.gamemode_picker.cur_item_id;
    var gm = DB.gamemodes[? gm_id];

    // GAMEMODE
    var gamemode = instance_create(0,0, gm[? "type"]);

    gamemode.mode = gm_id;
    gamemode.name = gm[? "name"];
    gamemode.is_coop = gm[? "is_coop"];
    gamemode.is_deathmatch = gm[? "is_deathmatch"];
    gamemode.team_based = gm[? "team_based"];

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

    close_frame(mod_tooltip_window);
    close_frame(play_menu_window);

    add_frame(player_setup_window);
}
