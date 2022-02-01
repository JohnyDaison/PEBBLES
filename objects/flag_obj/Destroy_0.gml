/// @description Reset Flag Spawner

if (!cancelled && instance_exists(my_flag_spawner)) {
    my_flag_spawner.reset_flag();
}

event_inherited();
