// this should eventually be removed and rely only on phys_body code
/*
push_hstrength = other.running*other.running_power/2;
push_vstrength = other.jumping_glidepower/2;

if(!other.lost_control && other.holographic == self.holographic)
{
    /*if(!instance_exists(my_shield))
    {
        push_hstrength = max(push_hstrength,2*abs(other.hspeed)/other.max_speed);
        push_vstrength = max(push_vstrength,2*abs(other.vspeed)/other.max_speed);
    }*//*
    
    x_dist = x - other.x;
    y_dist = y - other.y;
    
    
    //dir = point_direction(other.x,other.y,x,y);
    
    //dist = point_distance(other.x,other.y,x,y);
    

    if(!push_success)
    {
        push_orig_speed = speed;
    }
    
    x_dist = sign(x_dist)*push_hstrength;
    y_dist = sign(y_dist)*push_vstrength;
    
    push_success = false;
    if(!place_meeting(x+hspeed+x_dist, y+vspeed+y_dist, terrain_obj))
    {
        hspeed += x_dist;
        vspeed += y_dist;
        push_success = true;
    }
    
    if(!push_success && !place_meeting(x+hspeed+x_dist, y+vspeed, terrain_obj))
    {
        hspeed += x_dist;
        push_success = true;
    }
    
    if(!push_success && !place_meeting(x+hspeed, y+vspeed+y_dist, terrain_obj))
    {
        vspeed += y_dist;
        push_success = true;
    }
    
    if(push_success)
    {
        last_attacker_update(other.id, "body", "push");
    }
 
    with(other)
    {
        x_dist = -other.x_dist;
        y_dist = -other.y_dist;
        
        if(!push_success)
        {
            push_orig_speed = speed;
        }
        push_success = false;
        if(!place_meeting(x+hspeed+x_dist, y+vspeed+y_dist, terrain_obj))
        {
            hspeed += x_dist;
            vspeed += y_dist;
            push_success = true;
        }
        
        if(!push_success && !place_meeting(x+hspeed+x_dist, y+vspeed, terrain_obj))
        {
            hspeed += x_dist;
            push_success = true;
        }
        
        if(!push_success && !place_meeting(x+hspeed, y+vspeed+y_dist, terrain_obj))
        {
            vspeed += y_dist;
            push_success = true;
        }
        
        if(push_success)
        {
            last_attacker_update(other.id, "body", "push");
        }
    }
}
*/