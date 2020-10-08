/// @description  TURN
//travel_direction = (travel_direction + 90) mod 360;

alarm[3] = turn_delay;

if(move_tries > 0)
{
    exit;
}

var old_dir = travel_direction;
var new_direction = travel_direction;

if(!instance_exists(eat_target))
{
    new_direction = travel_direction + choose(-90, 0, 90);
}
else
{
    var dir = point_direction(x,y, eat_target.x, eat_target.y);
    if(dir != travel_direction)
    {
        var dist = point_distance(x,y, eat_target.x, eat_target.y);
        var turn_dir = sign(angle_difference(dir,travel_direction));
        if(dist == 32 || (dist > 128 && random(1) < 0.8))
        {
            new_direction = travel_direction + turn_dir*90;
        }
    }
}

var x_diff = lengthdir_x(32, new_direction);
var y_diff = lengthdir_y(32, new_direction);
var inst = instance_position(x + x_diff, y + y_diff, terrain_obj);

if(inst == noone || inst == eat_target)
{
    travel_direction = new_direction;
}

last_dir = travel_direction;

if(old_dir == travel_direction)
{
    alarm[3] = travel_delay;
}

