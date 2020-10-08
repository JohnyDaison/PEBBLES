/// @description  viewshake(camera, direction, strength)
/// @function  viewshake
/// @param camera
/// @param  direction
/// @param  strength
function viewshake(argument0, argument1, argument2) {
	var camera = argument0;
	var dir = argument1;
	var dist = argument2;

	if(instance_exists(camera))
	{
	    if(dist > camera.shake_dist)
	    {
	        camera.shake_dist = dist;
	        camera.shake_dir = (dir+180) mod 360;
	        camera.shake_source_dir = dir;
	    }
	}



}
