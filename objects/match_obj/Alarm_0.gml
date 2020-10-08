/// @description  START-UP GUY SPAWNERS
with(guy_spawner_obj)
{
    enabled = true;
}

// this is not completely correct, some turrets could be data_holder_obj by this time
with(turret_obj)
{
    increase_stat(my_player, "starting_turrets", 1, false);
}

alarm[1] = guy_spawner_obj.first_spawn_time;
