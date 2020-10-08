/// @description trigger(target, ...)
/// @function trigger
/// @param target
/// @param  ...
function trigger() {
	var retval = false;
	var target = argument[0];
	var log_str = "TRIGGER ";

	if(instance_exists(target))
	{
	    log_str += object_get_name(target.object_index) + " ";
    
	    if(target.triggerable) {
	        var count, args, i;
	        args[0] = 0;
	        count = argument_count-1;
        
	        log_str += script_get_name(target.trigger_script) + " ";
        
	        for(i=1;i<argument_count;i++)
	        {
	            args[i-1] = argument[i];
	            log_str += string(args[i-1]) + " ";
	        }
	        with(target)
	        {
	            retval = script_execute(trigger_script, count, args);
	        }
	    }
	}

	//my_console_log(log_str);

	return retval;



}
