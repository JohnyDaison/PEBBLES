var xx = -sign(keyboard_check(binds[? left])) + sign(keyboard_check(binds[? right]));
var yy = -sign(keyboard_check(binds[? up])) + sign(keyboard_check(binds[? down]));

current_dir = point_direction(0,0, xx, yy);
current_dist = point_distance(0,0, xx, yy);

current_aim_x = 0;
current_aim_y = 0;

if(current_dist > 0)
{
    current_aim_x = lengthdir_x(1, current_dir);
    current_aim_y = lengthdir_y(1, current_dir);
}

