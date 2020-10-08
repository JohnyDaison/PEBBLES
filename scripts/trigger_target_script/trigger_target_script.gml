/// @description trigger_target_script(as_obj)
/// @function trigger_target_script
/// @param as_obj
function trigger_target_script() {
	var as_obj = argument[0];

	var targets = self.trigger_targets;
	var count = ds_list_size(targets), i;

	with(as_obj)
	{
	    for(i=0; i<count; i++)
	    {
	        trigger(targets[| i]);
	    }
	}



}
