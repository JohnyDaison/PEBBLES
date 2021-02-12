function turret_assign_player(mount) {
    var closest_spawner = get_closest_spawner(mount.x, mount.y, true);

    if(instance_exists(closest_spawner) && instance_exists(closest_spawner.my_player))
    {
        mount.my_player = closest_spawner.my_player;
        mount.turret.my_player = mount.my_player;
    }
}
