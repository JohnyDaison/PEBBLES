/// @description  ASSIGN BLOCK AND PLAYER
var ter = instance_nearest(x-16,y-16,wall_obj);
var tc_x = ter.x+16;
var tc_y = ter.y+16;
var dist = point_distance(tc_x,tc_y,x,y);
var dir = point_direction(tc_x,tc_y,x,y);

if(dist <= 48)
{
    direction = dir;
    image_angle = dir;
    x = tc_x -1;
    y = tc_y -1;
    turret.center_offset_x = lengthdir_x(31,direction);
    turret.center_offset_y = lengthdir_y(31,direction);
    my_block = ter;
}

/// ASSIGN PLAYER
turret_assign_player(id);
/*
var closest_spawner = get_closest_spawner(x,y, true);

if(instance_exists(closest_spawner))
{
    my_player = closest_spawner.my_player;
    turret.my_player = my_player;
}
*/

