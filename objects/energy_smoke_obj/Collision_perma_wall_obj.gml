if(!bounced && !collided)
{
    var orig_x = x;
    var orig_y = y;
    
    x_return = xprevious - orig_x;
    y_return = yprevious - orig_y;
    
    var h_diff = xprevious - (other.x+16);
    var v_diff = yprevious - (other.y+16);
    
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

        if(abs(speed) < 0.2)
        {
            speed = 0;
        }
    }
}

