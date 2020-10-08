/// @description object_replace(from, to)
/// @function object_replace
/// @param from
/// @param  to
function object_replace(argument0, argument1) {
	var from = argument0;
	var to = argument1;
	var count = 0;
	var xx, yy; 

	with(from)
	{
	    xx = x;
	    yy = y;
    
	    instance_destroy();
	    instance_create(xx,yy, to);
    
	    count++;
	}

	return count;





}
