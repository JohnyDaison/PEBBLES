function phys_body_obj_push_other(blocking_object) {
    if(!push_success)
    {
        push_orig_speed = speed;
    }
    push_success = false;

    if(!place_meeting(x+hspeed+x_dist, y+vspeed+y_dist, blocking_object))
    {
        hspeed += x_dist;
        vspeed += y_dist;
        push_success = true;
    }
    
    if(!push_success && !place_meeting(x+hspeed+x_dist, y+vspeed, blocking_object))
    {
        hspeed += x_dist;
        push_success = true;
    }
    
    if(!push_success && !place_meeting(x+hspeed, y+vspeed+y_dist, blocking_object))
    {
        vspeed += y_dist;
        push_success = true;
    }
    
    if(push_success)
    {
        last_attacker_update(other.id, "body", "push");
    }
}
