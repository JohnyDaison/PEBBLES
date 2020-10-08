/// @description camera_resume(view)
/// @function camera_resume
/// @param view
function camera_resume(argument0) {
	var target_view = argument0;
	var ret = false;

	with(camera_obj)
	{
	    if(view == target_view)
	    {
	        if(instance_exists(my_override))
	        {
	            if(my_override.object_index == place_holder_obj && my_override.alarm[0] == -1)
	            {
	                my_override.die = true;
	            }
            
	            my_override = noone;
	        }
        
	        follow_override = false;
	        ret = true;
	    }
	}

	return ret;



}
