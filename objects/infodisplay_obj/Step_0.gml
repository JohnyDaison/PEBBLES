/*
if(script_exists(animation))
{
    if(start_step == -1)
    {
        start_step = singleton_obj.step_count;
    }
    var step = (singleton_obj.step_count - start_step) 
                mod script_execute(animation,-1,"length");
    script_execute(animation, step);    
}
*/

if(ready)
{
    if(shrink_anim_phase < 1)
    {
        shrink_anim_phase += shrink_anim_speed;
        if(shrink_anim_phase > 1)
        {
            shrink_anim_phase = 1;
        }
    }
    
    bg_anim_phase += bg_anim_speed;
    if(bg_anim_phase >= bg_anim_length)
    {
        bg_anim_phase = 0;  
    }
}
else
{
    if(shrink_anim_phase > 0)
    {
        shrink_anim_phase -= shrink_anim_speed;
        if(shrink_anim_phase <= 0)
        {
            shrink_anim_phase = 0;
            bg_anim_phase = 0;
        }
    }
}

//gives_light = (shrink_anim_phase == 1 && active);
gives_light = (shrink_anim_phase > 0); //  && active
ambient_light = shrink_anim_phase*ambient_light_full;