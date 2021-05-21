/// @description INIT - FIND MEMBER BLOCKS

//WAIT IF GUY IS TOO FAR
var near_guy = instance_nearest(x,y,player_guy);
if(instance_exists(near_guy))
{
    if(point_distance(x,y, near_guy.x, near_guy.y) > unfreeze_distance)
    {
        alarm[1] = 60;
        exit;
    }
}

// ASSEMBLE
cur_ter = instance_nearest(x,y, wall_obj);

var i, count, ter;

if(instance_exists(cur_ter) && cur_ter.x == x && cur_ter.y == y && cur_ter.cover != cover_indestr && !cur_ter.moving && !cur_ter.falling)
{
    snake_mob_assemble(head_size);
}

// SUCCESS
if(body_size >= head_size)
{
    var first = ter_group.members[| 0];
    var second = ter_group.members[| 1];
    travel_direction = point_direction(second.x, second.y, first.x, first.y);
    
    alive = true; 
    gamemode_obj.stats[? "snakes_alive"] += 1;
    my_sound_play(snake_sound);
    
    alarm[2] = travel_delay;
    alarm[3] = turn_delay;
    alarm[4] = recheck_delay - 1;
}
//FAIL
else
{
    instance_destroy();
}
