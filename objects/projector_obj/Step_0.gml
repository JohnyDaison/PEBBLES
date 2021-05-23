if(instance_exists(my_block))
{
    var block_color = my_block.my_next_color;
    var stabilised = tint_updated || my_color == g_octarine;
    
    // COPY BLOCK COLOR IF STABILISED
    if((my_color > g_dark || stabilised) 
        && my_color != block_color && my_block.tint_updated && block_color > g_dark)
    {
        my_color = block_color;
        stabilised = false;
    }
    
    if(my_color == g_dark && stabilised)
    {    
        // BLINK WITH STORED COLOR
        if(energy > 0 && my_last_color > g_dark)
        {
            my_color = my_last_color;
            stabilised = false;
        }
    }
    
    // DRAIN BLOCK
    if(my_color > g_dark)
    {
        if(my_block.energy >= energy_drain_step && energy <= max_energy+energy_drain_step)
        {
            energy += energy_drain_step;
            my_block.energy -= energy_drain_step;
            if(my_color != block_color)
            {
                my_color = block_color;
                stabilised = false;
            }
            if(my_block.energy < energy_drain_step)
            {
                my_block.my_next_color = g_dark;
            }
        }
    }
        
    // READY
    if(my_color > g_dark && stabilised)
    {
        // BLINK OFF IF LOW ENERGY
        if (!powered && energy < activation_threshold && block_color == g_dark)
        {
            my_last_color = my_color;
            my_color = g_dark;
            stabilised = false;
        }
        
        if (energy >= activation_threshold)
        {
            powered = true;
        }

        if(powered)
        {
            if(energy >= energy_use_step)
            {
                energy -= energy_use_step;
            }
            else
            {
                powered = false;
                my_last_color = my_color;
                my_color = g_dark;
                stabilised = false;
            }
        }   
    }
    
    if(!stabilised)
    {
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
