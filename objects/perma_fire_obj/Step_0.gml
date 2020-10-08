if(instance_exists(my_beam))
{
    my_beam.force = my_beam.orig_force;   
}
else if(instance_exists(my_turret))
{
    my_turret.my_block.energy = my_turret.my_block.outburst_threshold*1.1;   
    if(my_turret.my_block.my_color == g_black)
        my_turret.my_block.my_color = g_octarine;
}
else if(instance_exists(my_block))
{
    if(my_block.my_color == g_black)
    {
        my_block.my_next_color = g_octarine;
    }
    my_block.energy = my_block.outburst_threshold*1.1;
}
else
{
    my_turret = instance_nearest(x,y,beam_turret_mount_obj); 
    if(instance_exists(my_turret))
    { 
        if(instance_exists(my_turret.my_block) && distance_to_object(my_turret) < 48)
        {
            my_turret.my_block.energy = my_turret.my_block.outburst_threshold*1.1;   
        }
        else
        {
            my_turret = noone;
        }
    }
    
    // cannot be else
    if(!instance_exists(my_turret))
    {
        my_turret = instance_nearest(x,y,item_spawner_obj); 
        if(instance_exists(my_turret)) { 
            if(instance_exists(my_turret.my_block) && distance_to_object(my_turret) < 48)
            {
                my_turret.my_block.energy = my_turret.my_block.outburst_threshold*1.1;   
            }
            else
            {
                my_turret = noone;
            }
        }
    }
    
    my_beam = instance_nearest(x,y,beam_obj);
    if(instance_exists(my_beam))
    { 
        if(distance_to_object(my_beam) > 48)
        {
            my_beam = noone;   
        }
    }
    
    if(!instance_exists(my_turret))
    {
        my_turret = instance_nearest(x,y,turret_obj); 
        if(instance_exists(my_turret)) { 
            if(instance_exists(my_turret.my_block) && distance_to_object(my_turret) < 48)
            {
                my_turret.my_block.energy = my_turret.my_block.outburst_threshold*1.1;   
            }
            else
            {
                my_turret = noone;
            }
        }
    }
    
    if(!instance_exists(my_block))
    {
        my_block = instance_nearest(x,y,wall_obj); 
        if(instance_exists(my_block)) { 
            if(distance_to_object(my_block) > 3)
            {
                my_block = noone;
            }
        }
    }
}

