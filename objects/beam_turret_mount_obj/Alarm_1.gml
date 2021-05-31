/// @description  ASSIGN BLOCK AND PLAYER
var tries = 2;
var xx;

while(tries > 0 && !instance_exists(my_block))
{
    if(tries == 2)
        xx = 32;
    else
        xx = -32;
    var ter = instance_nearest(x+xx-16,y-16,wall_obj);
    var tc_x = ter.x+16;
    var tc_y = ter.y+16;
    var dist = point_distance(tc_x,tc_y,x,y);
    var dir = point_direction(tc_x,tc_y,x,y);
    
    if(dist <= 32 && y == tc_y)
    {
        direction = dir;
        aim_dir = dir;
        facing = sign(lengthdir_x(1,dir));
        facing_right = !!facing;
        image_angle = dir;
        x = tc_x;
        y = tc_y;
        my_block = ter;
    }
    tries--;
}

// ASSING PLAYER
turret_assign_player(id);
