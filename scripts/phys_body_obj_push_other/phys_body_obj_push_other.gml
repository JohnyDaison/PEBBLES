function phys_body_obj_push_other() {
	var coltype = argument[0];

	if(!push_success)
	{
	    push_orig_speed = speed;
	}
	push_success = false;

	if(!place_meeting(x+hspeed+x_dist, y+vspeed+y_dist, coltype))
	{
	    hspeed += x_dist;
	    vspeed += y_dist;
	    push_success = true;
	}
    
	if(!push_success && !place_meeting(x+hspeed+x_dist, y+vspeed, coltype))
	{
	    hspeed += x_dist;
	    push_success = true;
	}
    
	if(!push_success && !place_meeting(x+hspeed, y+vspeed+y_dist, coltype))
	{
	    vspeed += y_dist;
	    push_success = true;
	}
    
	if(push_success)
	{
	    last_attacker_update(other.id, "body", "push");
	}


}
