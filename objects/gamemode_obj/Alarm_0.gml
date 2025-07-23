/// @description START-UP GUY SPAWNERS / CREATE ALL THE THINGS
with(guy_spawner_obj)
{
    enabled = true;
}

// this is not completely correct, some turrets could be data_holder_obj by this time
with(turret_obj)
{
    increase_stat(my_player, "starting_turrets", 1, false);
}

var pl = 1;
var start_found = false;
var ordered_starts = ds_map_create();

with(level_start_obj)
{
    if(for_player == -1)
    {
        my_player = gamemode_obj.players[? pl++];
    }
    else
    {
        my_player = gamemode_obj.players[? for_player];
    }
    
    if(is_undefined(my_player))
    {
        my_player = noone;
        instance_destroy();
        continue;
    }
    
    activated = true;
    
    ordered_starts[? my_player.number] = id;
    
    start_found = true;
}

for (var i = 1; i <= player_count; i++) {
    var level_start = ordered_starts[? i];
    if (!is_undefined(level_start)) {
        with (level_start) {
            create_player_things(my_player);
        }
    }
}

ds_map_destroy(ordered_starts);

alarm[1] = 20;

if (!start_found && instance_exists(guy_spawner_obj)) {
    alarm[1] = guy_spawner_obj.first_spawn_time;
}
