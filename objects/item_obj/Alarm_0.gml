/// @description  HOVER
if(airborne || top_touching_ground)
{
    if(step > 0)
    {
        step -= 1;      
    }
        
}
else
{
    step += dir;
    if(step >= loop_height)
     dir = -1;
    if(step <= 0)
     dir = 1;
}

light_yoffset = -step-hover_offset;

alarm[0] = hover_rate;



