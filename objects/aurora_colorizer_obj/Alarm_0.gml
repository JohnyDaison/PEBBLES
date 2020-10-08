var aurora_count = ds_list_size(other.aurora_list);

with(wall_obj)
{
    if(place_meeting(x,y,other))
    {
        var index = (x div 32 + y div 32) mod aurora_count;
        
        my_next_color = my_next_color | other.aurora_list[| index];
        energy = max(energy,status_threshold);
    }
}

with(piezoplate_obj)
{
    if(place_meeting(x,y,other))
    {
        var index = (x div 32 + y div 32) mod aurora_count;
        
        my_color = my_color | other.aurora_list[| index];
        my_last_color = my_color;
        energy = max_energy;
        tint_updated = false;
    }
}

with(slime_mob_obj)
{
    if(place_meeting(x,y,other))
    {
        var index = (x div 32 + y div 32) mod aurora_count;
        
        my_color = other.aurora_list[| index];
        tint_updated = false;
    }
}

with(spark_obj)
{
    if(place_meeting(x,y,other))
    {
        while(abs(hspeed) < 1)
        {
            hspeed = random(6)-3;
        }
        var index = (x div 32 + y div 32) mod aurora_count;
        
        my_color = other.aurora_list[| index];
        tint_updated = false;
    }
}

instance_destroy();
