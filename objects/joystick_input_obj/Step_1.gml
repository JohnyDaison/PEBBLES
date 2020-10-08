action_inherited();
if(on)
{
    // BUTTONS
    
    for(but=1;but<11;but+=1)
    {
        but_down = joystick_check_button(number,but);
        if(but==9 || but==10)
            but_down = joystick_check_button(number,9) || joystick_check_button(number,10);
        
        if(states[# but,released])
        {
            states[# but,released] = false;
        }
        if(states[# but,pressed])
        {
            states[# but,pressed] = false;
        }
        if(but_down && !states[# but,held])
        {
            states[# but,pressed] = true;
            states[# but,held] = true;
            states[# but,free] = false;
            last_control = but;
        }
        if(!but_down && !states[# but,free])
        {
            states[# but,released] = true;
            states[# but,held] = false;
            states[# but,free] = true;
        }  
    }
    
    // TRIGGERS
    
    if(abs(joystick_zpos(number))>trigger_dead_zone)
    {
        if(joystick_zpos(number)<0)
        {
            trigger_down[0] = true;
            trigger_down[1] = false;
        }
        if(joystick_zpos(number)>0)
        {
            trigger_down[0] = false;
            trigger_down[1] = true;
        }     
    }
    else
    {
        trigger_down[0] = false;
        trigger_down[1] = false;
    }
    
    for(i=0;i<2;i+=1)
    {
        states[# joy_rtrigger+i,released]=false;
        states[# joy_rtrigger+i,pressed]=false;
        
        if(trigger_down[i] && !states[# joy_rtrigger+i,held])
        {
            states[# joy_rtrigger+i,pressed]=true;
            states[# joy_rtrigger+i,held]=true;
            states[# joy_rtrigger+i,free]=false;
            last_control=joy_rtrigger+i;
        }
        if(!trigger_down[i] && !states[# joy_rtrigger+i,free])
        {
            states[# joy_rtrigger+i,released]=true;
            states[# joy_rtrigger+i,held]=false;
            states[# joy_rtrigger+i,free]=true;
        }    
    }
    
    // ANALOG STICKS AND D-PAD
    
    // xpos,ypos,pov
    analog_dist_left1 = point_distance(0,0,joystick_xpos(number),joystick_ypos(number));
    analog_dist_right1 = point_distance(0,0,joystick_upos(number),joystick_rpos(number));
    pov_dir = joystick_pov(number);

    // joy to arrows conversion
    for(i=0;i<4;i+=1)
    {
        arrow[i] = false;
        dpad[i] = false;
    }
    dist = 0;
    dir = 0;
    
    if(analog_dist_left1 > analog_dead_zone)
    {
        dir = point_direction(0,0,joystick_xpos(number),joystick_ypos(number));
        dist = 1;
    
        if((0 <= dir && dir < hor_zone) || ((360-hor_zone) <= dir && dir < 360))
            arrow[right]=true;
        if((90-vert_zone) <= dir && dir < (90+vert_zone))
            arrow[up]=true;
        if((180-hor_zone) <= dir && dir < (180+hor_zone))
            arrow[left]=true;
        if((270-vert_zone) <= dir && dir < (270+vert_zone))
            arrow[down]=true;
    }
    
    if(analog_dist_right1 > analog_dead_zone)
    {
        dir = point_direction(0,0,joystick_upos(number),joystick_rpos(number));
        dist = 1;
    
        if((0 <= dir && dir < hor_zone) || ((360-hor_zone) <= dir && dir < 360))
            arrow[right]=true;
        if((90-vert_zone) <= dir && dir < (90+vert_zone))
            arrow[up]=true;
        if((180-hor_zone) <= dir && dir < (180+hor_zone))
            arrow[left]=true;
        if((270-vert_zone) <= dir && dir < (270+vert_zone))
            arrow[down]=true;
    }
    
        
    // D-PAD
    if (pov_dir != -1)
    {
        dir =((-(pov_dir-90))+360) mod 360;
        dist = 1;      

        if((0 <= dir && dir < hor_zone) || ((360-hor_zone) <= dir && dir < 360))
            dpad[right]=true;
        if((90-vert_zone) <= dir && dir < (90+vert_zone))
            dpad[up]=true;
        if((180-hor_zone) <= dir && dir < (180+hor_zone))
            dpad[left]=true;
        if((270-vert_zone) <= dir && dir < (270+vert_zone))
            dpad[down]=true;

    }
    
    /*
    show_debug_message("AD: "+string(analog_dist_left1)+" pov: "+string(pov_dir)
                    +" dir: "+string(dir)+" dist: "+string(dist)
                    +" arrows: "+string(arrow[up])+" "+string(arrow[down])+" "+string(arrow[left])+" "+string(arrow[right]));
    */
    
    // analog directions
    analog_start = joy_right;
    
    for(i=0;i<4;i+=1)
    {
        if(states[# analog_start+i,released])
        {
            states[# analog_start+i,released]=false;
        }
        if(states[# analog_start+i,pressed])
        {
            states[# analog_start+i,pressed]=false;
        }
        if(arrow[i] && !states[# analog_start+i,held])
        {
            states[# analog_start+i,pressed]=true;
            states[# analog_start+i,held]=true;
            states[# analog_start+i,free]=false;
            last_control=analog_start+i;
        }
        if(!arrow[i] && !states[# analog_start+i,free])
        {
            states[# analog_start+i,released]=true;
            states[# analog_start+i,held]=false;
            states[# analog_start+i,free]=true;
        }   
    }
    
    // D-PAD direction
    dpad_start = joy_dpad_right;
    
    for(i=0;i<4;i+=1)
    {
        if(states[# dpad_start+i,released])
        {
            states[# dpad_start+i,released]=false;
        }
        if(states[# dpad_start+i,pressed])
        {
            states[# dpad_start+i,pressed]=false;
        }
        if(dpad[i] && !states[# dpad_start+i,held])
        {
            states[# dpad_start+i,pressed]=true;
            states[# dpad_start+i,held]=true;
            states[# dpad_start+i,free]=false;
            last_control=dpad_start+i;
        }
        if(!dpad[i] && !states[# dpad_start+i,free])
        {
            states[# dpad_start+i,released]=true;
            states[# dpad_start+i,held]=false;
            states[# dpad_start+i,free]=true;
        }   
    }
}

/* */
/*  */
