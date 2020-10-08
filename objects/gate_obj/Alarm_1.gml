/// @description  ASSIGN BLOCK
var ter = instance_nearest(x-16,y-16,terrain_obj);
var tc_x = ter.x+16;
var tc_y = ter.y+16;
var dist = point_distance(tc_x,tc_y,x,y);
//var dir = point_direction(tc_x,tc_y,x,y);

if(dist == 0)
{
    my_block = ter;
    x--;
    y--;
}
else
{
    instance_destroy();
}

/// ASSIGN PLAYER
var closest_spawner = get_closest_spawner(x,y, true);

if(instance_exists(closest_spawner) && instance_exists(closest_spawner.my_player))
{
    my_player = closest_spawner.my_player;
}

