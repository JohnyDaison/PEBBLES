if(place_meeting(xprevious, yprevious, other.id))
{
    if(speed > 0)
    {
        speed *= 1.3;
    }
}

gate_bounce_count += 1;
gate_bounced = true;

if(gate_bounce_count > gate_bounce_limit)
{
    collided = true;
}

if(!bounced && !collided)
{
    var orig_x = x;
    var orig_y = y;
    
    x_return = xprevious - orig_x;
    y_return = yprevious - orig_y;
    
    if(other.horizontal)
    {
        vspeed *= -1;
        vspeed += sign(x_return)*0.2;
        bounced = true;
        corner_bounced = false;
        //show_debug_message("vert bounce");
    }
    
    if(other.vertical)
    {
        hspeed *= -1;
        hspeed += sign(y_return)*0.2;
        bounced = true;
        corner_bounced = false;
        //show_debug_message("hor bounce");
    }
    
    if(bounced)
    {
        my_sound_play_colored(shot_bounce_sound, my_color, false, sound_volume);
    }
}

