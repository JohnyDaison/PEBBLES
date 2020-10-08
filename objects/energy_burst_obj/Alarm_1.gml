if(!done_for && instance_exists(my_guy))
{
    my_color = my_guy.my_color;
    tint_updated = false;
    
    image_angle = direction;
    var rads = degtorad(image_angle);
    
    base_xcoord = -cos(rads);
    base_ycoord = sin(rads);
    
    right_xcoord = -cos(rads-pi/2);
    right_ycoord = sin(rads-pi/2);
    
    if(base_ycoord != 0 && right_xcoord != 0) // vertical burst
    {
        x1 = x + right_xcoord*14;
        x2 = x - right_xcoord*15;
        
        y1 = y + base_ycoord*17;
        y2 = y + base_ycoord*17;
        
        x3 = x + right_xcoord*14;
        x4 = x - right_xcoord*15; 
        
        y3 = y - base_ycoord*15;
        y4 = y - base_ycoord*15;
    }
    
    if(base_xcoord != 0 && right_ycoord != 0) // horizontal burst
    {
        
        x1 = x + base_xcoord*17;
        x2 = x + base_xcoord*17;
        
        y1 = y + right_ycoord*14;
        y2 = y - right_ycoord*15;
        
        x3 = x - base_xcoord*15;
        x4 = x - base_xcoord*15; 
        
        y3 = y + right_ycoord*14;
        y4 = y - right_ycoord*15;
    }
}
else
{
    done_for = true;
}

