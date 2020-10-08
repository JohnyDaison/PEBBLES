/// @description kill_all_command([object])
/// @function kill_all_command
/// @param [object]
function kill_all_command() {
	var object = noone;

	if(argument_count > 0)
	{
	    object = argument[0];   
	}

	var count = 0;
	if(object == noone)
	{
	    object = game_obj;
	}

	with(object)
	{
	    instance_destroy();
	    count++;
	}

	return count;


}
