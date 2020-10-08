/// @description my_move_bounce(type)
/// @function my_move_bounce
/// @param type
function my_move_bounce() {
	var type = argument[0];
	var ret = false;
	if(instance_exists(type))
	{
	    var h_blocked = place_meeting(x + hspeed, y, type);
	    var v_blocked = place_meeting(x, y + vspeed, type);
    
	    if(h_blocked)
	    {
	        hspeed *= -1;
	        ret = true;
	    }
	    if(v_blocked)
	    {
	        vspeed *= -1;
	        ret = true;
	    }
	    /*
	    if(!h_blocked && !v_blocked)
	    {
	        var diag_blocked = place_meeting(x + hspeed, y + vspeed, type);
    
	        if(diag_blocked)
	        {
	            hspeed *= -1;
	            vspeed *= -1;
	            ret = true;
	        }
	    }
	    */
    
	}

	return ret;



}
