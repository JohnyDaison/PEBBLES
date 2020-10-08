/// @description BURSTING
event_inherited();

/// BURSTING
if((falling || moving || burst_recheck) && singleton_obj.step_count mod 5 == 0)
{
    burst_recheck = false;
    if(bursting)
    {
        var dir, burst_x, burst_y, ter, i;
        
        burst_count = 0;
        
        for(i=0; i<=3; i+=1) 
        {
            dir = i*90;
            burst_x = x+16+lengthdir_x(32,dir);
            burst_y = y+16+lengthdir_y(32,dir);
    
            if (!place_meeting(burst_x -(burst_x mod 32), burst_y - (burst_y mod 32), solid_terrain_obj)) 
            {
                burst = instance_position(burst_x, burst_y, energy_burst_obj);
                if(instance_exists(burst) && burst.my_guy == id)
                {
                    burst_count += 1;
                }
                else
                {
                    burst = instance_create(burst_x, burst_y, energy_burst_obj);
                    burst.direction = dir;
                    burst.my_guy = id;
                    burst.my_source = object_index;
                    burst.my_color = my_color;
                    burst.tint_updated = false;
                    burst.holographic = holographic;
                    burst_count += 1;
                }
            }
        }
    }
}

