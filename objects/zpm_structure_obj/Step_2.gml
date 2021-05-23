if(!instance_exists(my_block))
{
    my_block = instance_nearest(x -16,y -16, wall_obj);
    if(!place_meeting(x,y, my_block))
    {
        instance_destroy();
    }
    else
    {
        x = my_block.x + 15;
        y = my_block.y + 15;
    }
}

// PRESERVE COLOR
if(my_block.my_color > g_dark)
{
    last_block_color = my_block.my_color;
    if(my_block.my_next_color == g_dark)
    {
        my_block.my_next_color = my_block.my_color;
    }
}
else if(last_block_color > g_dark)
{
    my_block.my_color = last_block_color;
    my_block.my_next_color = last_block_color;
    my_block.tint_updated = false;
}

// GIVE ENERGY TO BLOCK
my_block.energy += energy_tick;

event_inherited();