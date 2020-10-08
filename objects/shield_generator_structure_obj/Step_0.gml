if(instance_exists(my_holder))
{
    var block_color;
    if(instance_exists(my_block))
    {
        block_color = my_block.my_next_color;
    }
    else
    {
        block_color = my_holder.my_color;
    }
    
    var stabilised = tint_updated && block_color != g_octarine;
    
    // COPY BLOCK COLOR IF STABILISED
    if((my_color > g_black || stabilised) 
        && my_color != block_color && my_holder.tint_updated && block_color > g_black && block_color < g_octarine)
    {
        my_color = block_color;
        stabilised = false;
    }
    
    if(my_color == g_black && stabilised)
    {    
        // BLINK WITH STORED COLOR
        if(energy > 0 && my_last_color > g_black)
        {
            my_color = my_last_color;
            stabilised = false;
        }
    }
    
    // DRAIN HOLDER
    if(my_color > g_black && stabilised)
    {
        if(my_holder.energy > 0 && block_color < g_octarine)
        {
            if(my_color != block_color)
            {
                my_color = block_color;
                stabilised = false;
            }
            
            if(instance_exists(my_block) && my_block.energy > my_block.active_threshold)
            {
                energy += my_block.energy - my_block.active_threshold;
                my_block.energy = my_block.active_threshold;
            }
            /*
            if(instance_exists(my_struct))
            {
                energy += my_holder.energy;
                my_struct.energy = 0;
            }
            */
        }
    }
        
    // READY
    if(my_color > g_black && stabilised)
    {
        // BLINK OFF IF LOW ENERGY
        if (energy < activation_threshold)
        {
            my_last_color = my_color;
            my_color = g_black;
            stabilised = false;
        }
        else
        {
            // SHIELD RECHARGE
            if(!instance_exists(my_shield) && self.shield_ready)
            {
                self.my_shield = instance_create(x,y,shield_obj);
                my_shield.my_guy = id;
                my_shield.my_source = object_index;
                my_shield.max_charge = shield_max_charge;
                my_shield.charge = my_shield.max_charge;
                my_shield.size_coef = shield_size;
                my_shield.low_charge_ratio = 0.5;
                my_shield.field_power = 2;
                my_shield.my_color = my_color;
                my_shield.my_player = my_player;
                my_shield.draw_bar = draw_shield_bar;
                my_shield.holographic = holographic;
                my_sound_play(shield_ready_sound);
                
                my_holder.my_shield = my_shield;
            }
            
            if (instance_exists(my_shield))
            {
                if(my_shield.max_charge - my_shield.charge > energy)
                {
                    my_shield.charge += energy;
                    energy = 0;
                }
                
                if(my_shield.my_color != my_color)
                {
                    my_shield.my_color = my_color;
                    my_shield.tint_updated = false;
                }
            }
        }   
    }
    
    if(!stabilised)
    {
        tint_updated = false;
    }
    
    if(!instance_exists(my_shield) && my_shield != noone)
    {
        my_shield = noone;
        my_holder.my_shield = my_shield;
    }
}
else
{
    if(my_holder != noone)
    {
        instance_destroy();
    }
}

