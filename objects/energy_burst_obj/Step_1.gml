if(!done_for && instance_exists(my_guy) && !position_meeting(x,y, solid_terrain_obj))
{
    if(!my_guy.tint_updated)
    {
        my_color = my_guy.my_color;
        tint_updated = false;
    }  
    
    // this should be constant
    // energy = my_guy.energy / ( (my_guy.burst_count + my_guy.spread_count) * 4 );
    
    if(!my_guy.bursting)
    {
        done_for = true;
    }
}
else
{
    done_for = true;
}

event_inherited();
