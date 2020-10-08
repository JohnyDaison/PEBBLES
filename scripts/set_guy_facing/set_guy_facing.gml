/// @description set_guy_facing(right)
/// @function set_guy_facing
/// @param right
function set_guy_facing() {

	facing_right = !!argument[0];
	if(!frozen_in_time && status_left[? "frozen"] == 0)
	{
	    if(facing_right)
	    {
	        facing = 1; 
	    }
	    else
	    {
	        facing = -1;
	    }
	}


}
