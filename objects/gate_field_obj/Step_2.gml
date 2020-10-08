alpha += alpha_dir*alpha_speed;
if(alpha_dir == -1)
{
    if(alpha <= min_alpha)
    {
        alpha = min_alpha;
        alpha_dir = 1;
    }   
}
else if (alpha_dir == 1)
{
    if(alpha >= max_alpha)
    {
        alpha = max_alpha;
        alpha_dir = -1;
    }
}

ambient_light = alpha;

event_inherited();