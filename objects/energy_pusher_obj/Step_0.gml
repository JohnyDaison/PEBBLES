if(instance_exists(my_block))
{  
    if(singleton_obj.step_count > tick_delay && singleton_obj.step_count mod tick_delay == tick_phase)
    {
        var prev = my_block.near_walls[? ((direction+180) mod 360)/90];
        var next = my_block.near_walls[? direction/90];
        
        push_block_energy(my_block, next,
            my_block_min_tick_energy, energy_tick,
            my_block_min_energy, next_block_max_energy);
        
        if(instance_exists(prev) && !prev.has_pusher)
        {
            push_block_energy(prev, my_block,
                prev_block_min_tick_energy, energy_tick,
                prev_block_min_energy, my_block_max_energy);
        }
        
        if(my_block.my_color > g_black || my_block.my_next_color > g_black)
        {
            my_color = g_white;
        }
        else
        {
            my_color = g_black;
        }
        tint_updated = false;
    }    
        
}
else
{
    if(my_block != noone)
    {
        instance_destroy();
    }
}

