if(xstart == x && ystart == y)
{
    collided = true;
    if(!wallhit_played)
    {
        //my_sound_play_colored(shot_wallhit_sound, my_color);
        my_sound_play(shot_wallhit_sound);
        wallhit_played = true;
    }
}

if(!bounced && !collided)
{
    var orig_x = x;
    var orig_y = y;
    
    x_return = xprevious - orig_x;
    y_return = yprevious - orig_y;
    
    var h_diff = xprevious - (other.x+15);
    var v_diff = yprevious - (other.y+15);
    
    if(abs(v_diff) >= abs(h_diff))
    {
        if(abs(hspeed) > abs(vspeed) && sign(v_diff) == -sign(vspeed))
        {
            vspeed *= -1;
            bounced = true;
            corner_bounced = false;
            //show_debug_message("vert bounce");
        }
    }
    
    if(abs(h_diff) >= abs(v_diff))
    {
        if(abs(hspeed) < abs(vspeed) && sign(h_diff) == -sign(hspeed))
        {
            hspeed *= -1;
            bounced = true;
            corner_bounced = false;
            //show_debug_message("hor bounce");
        }
    }
    
    if(speed < 1 && y < other.y)
    {
        bounced = false;
    }
    
    if(bounced)
    {
        speed -= 0.2;
        //my_sound_play_colored(shot_bounce_sound, my_color);
        my_sound_play(shot_bounce_sound);
    }
    else
    {
        collided = true;
        if(!wallhit_played)
        {
            //my_sound_play_colored(shot_wallhit_sound, my_color);
            my_sound_play(shot_wallhit_sound);
            wallhit_played = true;
        } 
    }
}

