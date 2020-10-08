if(sprite_index == wall_burst_end_spr)
{
    instance_destroy();     
}

if(sprite_index == wall_burst_loop_spr)
{
    if(done_for)
    {
        sprite_index = wall_burst_end_spr;
    }  
}
   
if(sprite_index == wall_burst_start_spr)
{
    if(!done_for)
    {
        sprite_index = wall_burst_loop_spr;
    }    
    else
    {
        sprite_index = wall_burst_end_spr;
    }
}

