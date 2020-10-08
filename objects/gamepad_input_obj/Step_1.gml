event_inherited();

if(on)
{
    // ANALOG STICKS
    var xx,yy, dist;
    
    analog_dist_left = point_distance(0,0, gamepad_axis_value(index, gp_axislh), gamepad_axis_value(index, gp_axislv));
    analog_dist_right = point_distance(0,0, gamepad_axis_value(index, gp_axisrh), gamepad_axis_value(index, gp_axisrv));
    
    current_aim_x = 0;
    current_aim_y = 0;
    current_dist = 0;
    
    xx = gamepad_axis_value(index, gp_axislh);
    yy = gamepad_axis_value(index, gp_axislv);
    dist = point_distance(0,0, xx, yy);
    
    if(current_dist == 0 && dist > analog_dead_zone)
    {
        current_dist = dist;
        current_aim_x = xx;
        current_aim_y = yy;
    }
    
    xx = gamepad_axis_value(index, gp_axisrh);
    yy = gamepad_axis_value(index, gp_axisrv);
    dist = point_distance(0,0, xx, yy);
    
    if(current_dist == 0 && dist > analog_dead_zone)
    {
        current_dist = dist;
        current_aim_x = xx;
        current_aim_y = yy;
    }

    // gamepad to arrows conversion
    for(i=0;i<4;i+=1)
    {
        arrow[i] = false;
        //dpad[i] = false;
    }
    dist = 0;
    dir = 0;
    
    if(analog_dist_left > analog_dead_zone)
    {
        dir = point_direction(0,0, gamepad_axis_value(index, gp_axislh), gamepad_axis_value(index, gp_axislv));
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
    
    if(analog_dist_right > analog_dead_zone)
    {
        dir = point_direction(0,0, gamepad_axis_value(index, gp_axisrh), gamepad_axis_value(index, gp_axisrv));
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

    // update directions states    
    dir_start = gamepad_right;

    for(i=0;i<4;i+=1)
    {
        if(states[# dir_start+i,released])
        {
            states[# dir_start+i,released]=false;
        }
        if(states[# dir_start+i,pressed])
        {
            states[# dir_start+i,pressed]=false;
        }
        if(arrow[i] && !states[# dir_start+i,held])
        {
            states[# dir_start+i,pressed]=true;
            states[# dir_start+i,held]=true;
            states[# dir_start+i,free]=false;
            last_control = dir_start+i;
        }
        if(!arrow[i] && !states[# dir_start+i,free])
        {
            states[# dir_start+i,released]=true;
            states[# dir_start+i,held]=false;
            states[# dir_start+i,free]=true;
        }   
    }
    
    // COMBINED STICK PRESS
    var sticks = gamepad_button_check(index, gp_stickl) || gamepad_button_check(index, gp_stickr);
    sticks_index = gamepad_stick;
    
    states[# sticks_index, released] = false;
    states[# sticks_index, pressed] = false;
    if(sticks && !states[# sticks_index, held])
    {
        states[# sticks_index, pressed] = true;
        states[# sticks_index, held] = true;
        states[# sticks_index, free] = false;
        last_control = gamepad_stick;
    }
    if(!sticks && !states[# sticks_index, free])
    {
        states[# sticks_index, released] = true;
        states[# sticks_index, held] = false;
        states[# sticks_index, free] = true;
    }  
    
    if(instance_exists(camera) && singleton_obj.force_feedback)
    {
        if(camera.shake_dist > 0)
        {
            x_diff = lengthdir_x(1,camera.shake_source_dir);
            
            r_coef = (x_diff+1)/2;
            l_coef = 1-r_coef;
            
            dist_coef = min(1, camera.shake_dist/15);

            gamepad_set_vibration(index, dist_coef*l_coef, dist_coef*r_coef);
        }
        else
            gamepad_set_vibration(index, 0, 0);
    }
    else
        gamepad_set_vibration(index, 0, 0);
}


