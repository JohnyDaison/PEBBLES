/// @description  ASSIGN MY BLOCK
if(!instance_exists(my_block))
{
    my_block = instance_nearest(x,y, wall_obj);
    if(!place_meeting(x,y, my_block))
    {
        instance_destroy();
    }
    else
    {
        x = my_block.x;
        y = my_block.y;
    }
}

event_inherited();