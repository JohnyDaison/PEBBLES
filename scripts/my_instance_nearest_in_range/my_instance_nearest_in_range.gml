/// @description my_instance_nearest_in_range(x, y, object, range)
/// @param x
/// @param y
/// @param type
/// @param range
function my_instance_nearest_in_range() {

	var xx = argument[0];
	var yy = argument[1];
	var object = argument[2];
	var range = argument[3];

	var result = noone;

	var near, dist;
	near = instance_nearest(xx, yy, object);
	dist = my_instance_center_distance(xx, yy, near);
            
	if(dist != -1 && (range == -1 || dist < range))
	{
	    result = near;
	}



}
