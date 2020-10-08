/*
if(debug_mode)
{
    show_debug_message("Item collision");
}
*/
if(!collected && !other.collected && !used && !other.used && !placed && !other.placed
&& ((!is_duplicate && !other.is_duplicate) || object_index != other.object_index))
{
    if(object_index == other.object_index && other.my_color == my_color
    && stack_size > 0 && stack_size+other.stack_size <= max_stack_size
    && for_player == other.for_player)
    {
        stack_size += other.stack_size;
        other.stack_size = 0;
        x = (x+other.x)/2;
        y = (y+other.y)/2;
        hspeed = (hspeed+other.speed/2);
        vspeed = (vspeed+other.vspeed/2);
        speed *= 0.5;
        with(other)
        {
            instance_destroy();
        }
    }
    else
    {
        push_hstrength = 2*abs(other.hspeed)/other.max_speed;
        push_vstrength = 2*abs(other.vspeed)/other.max_speed;
        x_dist = x - other.x;
        y_dist = y - other.y;
        
        /*
        dir = point_direction(other.x,other.y,x,y);
        */
        //dist = point_distance(other.x,other.y,x,y);
        
        if(x_dist == 0)
        {
            x_dist = round(random(1))*2 -1;
            push_hstrength = max(0.1,push_hstrength);
        }
        /*
        if(y_dist == 0)
        {
            y_dist = round(random(1))*2 -1;
            push_vstrength = max(0.1,push_vstrength);
        }
        */
        if(!push_success)
        {
            push_orig_speed = speed;
        }
        
        x_dist = sign(x_dist)*push_hstrength;
        y_dist = sign(y_dist)*push_vstrength;
        
        push_success = false;
        if(!place_meeting(x+hspeed+x_dist,y+vspeed+y_dist,terrain_obj))
        {
            hspeed += x_dist;
            vspeed += y_dist;
            x += sign(x_dist);
            y += sign(y_dist);
            push_success = true;
        }
        
        if(!push_success && !place_meeting(x+hspeed+x_dist,y+vspeed,terrain_obj))
        {
            hspeed += x_dist;
            x += sign(x_dist);
            push_success = true;
        }
        
        if(!push_success && !place_meeting(x+hspeed,y+vspeed+y_dist,terrain_obj))
        {
            vspeed += y_dist;
            y += sign(y_dist);
            push_success = true;
        }
     
        /*
        with(other)
        {
            x_dist = -other.x_dist;
            y_dist = -other.y_dist;
            
            if(!push_success)
            {
                push_orig_speed = speed;
            }
            push_success = false;
            if(!place_meeting(x+hspeed+x_dist,y+vspeed+y_dist,terrain_obj))
            {
                hspeed += x_dist;
                vspeed += y_dist;
                push_success = true;
            }
            
            if(!push_success && !place_meeting(x+hspeed+x_dist,y+vspeed,terrain_obj))
            {
                hspeed += x_dist;
                push_success = true;
            }
            
            if(!push_success && !place_meeting(x+hspeed,y+vspeed+y_dist,terrain_obj))
            {
                vspeed += y_dist;
                push_success = true;
            }
        }
        */
    }
}
