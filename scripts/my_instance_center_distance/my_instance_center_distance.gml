/// @description my_instance_center_distance(x, y, instance)
/// @param x
/// @param y
/// @param instance
function my_instance_center_distance() {

	var xx = argument[0];
	var yy = argument[1];
	var instance = argument[2];

	var instance, instance_xx, instance_yy;

	if(instance_exists(instance))
	{
	    instance_xx = instance.x;
	    instance_yy = instance.y;
    
	    if(obj_center_offset)
	    {
	        instance_xx += instance.obj_center_xoff;
	        instance_yy += instance.obj_center_yoff;
	    }
            
	    return point_distance(xx, yy, instance_xx, instance_yy);
	}
	else
	{
	    return -1;   
	}


}
