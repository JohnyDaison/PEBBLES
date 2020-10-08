life_left = alarm[0];

if(life_left == -1)
{
    fading = false;
    fading_in = false;
    fading_out = false;
    fade_ratio = max_alpha;
}
else if(life_left < fade_out_length)
{
    fading = true;
    fading_out = true;
}

if(fading)
{
    if(fading_in)
    {
        var fade_in_left = life_left - max_alpha_length - fade_out_length;
        fade_ratio = clamp( max_alpha * (1 - (fade_in_left/fade_in_length)), min_alpha, max_alpha);
        y -= 2*rise_speed;
        
        if (fade_ratio == max_alpha)
        {
            fading_in = false;   
        }
    }
    
    if(fading_out)
    {
        fade_ratio = clamp(max_alpha * life_left/fade_out_length, 0, max_alpha);
        y -= rise_speed;
    }
}

