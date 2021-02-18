/// @description guy_spawn_point_create(spawner, player, [activated])
/// @param spawner
/// @param player
/// @param [activated]
function guy_spawn_point_create() {
    var spawner = argument[0];
    var player = argument[1];
    var activated = undefined;

    if(argument_count > 2)
    {
        activated = argument[2];
    }

    if(is_undefined(spawner.spawn_points[? player.number]))
    {
        var ii = instance_create(spawner.x, spawner.y, guy_spawn_point_obj);
        ii.my_spawner = spawner;
        ii.my_player = player;
    
        if(!is_undefined(activated))
        {
            ii.activated = activated;
        }

        spawner.spawn_points[? player.number] = ii;
    }
}
