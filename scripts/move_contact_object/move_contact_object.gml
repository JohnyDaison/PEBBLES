/// @description move_contact_object(x_dist,y_dist,target)
/// @function move_contact_object
/// @param x_dist
/// @param y_dist
/// @param target
function move_contact_object(argument0, argument1, argument2) {
	var x_dist,y_dist,target,coef,orig_x,orig_y,xx,yy;
	x_dist = argument0;
	y_dist = argument1;
	target = argument2;

	if(x_dist != 0 || y_dist != 0)
	{
	    if(abs(x_dist) < 1 && abs(y_dist) < 1)
	    {
	        x_dist = sign(x_dist);
	        y_dist = sign(y_dist);
	    }
    
	    if(abs(x_dist) > abs(y_dist))
	    {
	        coef = abs(1/x_dist);
	    }
	    else
	    {
	        coef = abs(1/y_dist);
	    }
    
	    /*
	    if(y_dist != 0)
	    {
	        coef = abs(1/y_dist);
	    }
	    else
	    {
	        coef = abs(1/x_dist);
	    }
	    */
	    orig_x = x;
	    orig_y = y;
    
	    xx = x_dist*coef;
	    yy = y_dist*coef;
    
	    x_dist = abs(x_dist) - abs(xx);
	    y_dist = abs(y_dist) - abs(yy);
    
	    while(!place_meeting(round(x+xx),round(y+yy),target) && (abs(x-orig_x) <= x_dist) && (abs(y-orig_y) <= y_dist))
	    {
	        x += xx;
	        y += yy;
	    }
    
	    x = round(x);
	    y = round(y);
	}



}
