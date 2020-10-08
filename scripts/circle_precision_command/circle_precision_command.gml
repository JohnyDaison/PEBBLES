/// @description circle_precision_command([precision])
/// @function circle_precision_command
/// @param precision
function circle_precision_command() {

	var precision;
	var set_it = false;

	if (argument_count > 0)
	{
	    precision = argument[0];
	    set_it = true;
	}

	if(set_it)
	{
	    if(precision mod 4 != 0 || precision <= 0 || precision > 64)
	    {
	        return "Invalid precision, must be positive multiple of 4, 4 - 64."
	    }

	    DB.circle_precision = precision;

	    draw_set_circle_precision(precision);
    
	    return "Set to " + string(precision);
	}
	else
	{
	    return string(DB.circle_precision);
	}



}
