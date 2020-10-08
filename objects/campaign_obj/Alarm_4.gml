/// @description  END OF LEVEL
close_frame(center_overlay);

with(place_controller_obj)
{
    instance_destroy();
}

do_room_cleanup();

var cur_index = ds_list_find_index(world.places, world.current_place);
var next = (world.places[|(cur_index+1)]);

// add current stats to tournament_stats

if(reached_limit_name != "user_terminated" && next && instance_exists(next))
{
    world.current_place = next.id;
    arena_name = next.name;
    single_cam = world.current_place.single_cam;
    limit_reached = false;
    match_finished = false;
    shown_welcome = false;
    closed_welcome = false;
    created_gui = false;
    match_started = false;
    
    winner = noone;
    loser = noone;
    ds_list_clear(losers);
    time_window = noone;
    battlefeed = noone;
    
    init_match_stats();
    
    mods_update_state(mode, world.current_place, custom_mods, mods_state);
    
    room_goto(next.room_id);
}
else
{
    if(mode == "quick_tutorial" || mode == "training")
    {
        goto_mainmenu();
    }
    else
    {
        goto_summary();
    }
}

