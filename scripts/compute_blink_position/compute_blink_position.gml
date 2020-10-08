/// @description compute_blink_position(direction)
/// @function compute_blink_position
/// @param direction
function compute_blink_position() {

	var tp_dir = argument[0];
	var tp_dist = 256;
	var tp_step = 32;

	var result = ds_map_create();
	register_ds("results", ds_type_map, result, id);

	var hor_coef = lengthdir_x(1, tp_dir);
	var ver_coef = lengthdir_y(1, tp_dir);
	var reduce_dist = 0

	var xx = x;
	var yy = y;

	xx += tp_dist*hor_coef;
	yy += tp_dist*ver_coef;
    
	while( (place_meeting(xx,yy, terrain_obj) || place_meeting(xx,yy, teleport_blocker_obj))
	    && reduce_dist < tp_dist)
	{
	    if ((reduce_dist + tp_step) < tp_dist)
	    {
	        xx -= tp_step*hor_coef;
	        yy -= tp_step*ver_coef;
	        reduce_dist += tp_step;    
	    }
	    else
	    {
	        xx = x;
	        yy = y;
	        reduce_dist = tp_dist
	    }
	}

	result[? "x"] = xx;
	result[? "y"] = yy;
	result[? "dist"] = tp_dist - reduce_dist;

	return result;


}
