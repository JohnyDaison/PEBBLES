if(ready && !reset)
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
            reset = false;
        }
    }
}

gives_light = (shrink_anim_phase > 0);
ambient_light = shrink_anim_phase*ambient_light_full;
