/// @description Get a string name for a physical input
/// @function get_const_name(input_method, code)
/// @param input_method  the input device
/// @param code  the input id
function get_const_name(argument0, argument1) {
	var input_method = argument0;
	var code = argument1;
	var val = undefined;

	if(input_method == keyboard)
	{
	    if(code >= ord("A") && code <= ord("Z"))
	    {
	        val = chr(code);   
	    }
	    else
	    {
	        val = DB.keynames[? code];
	    }
	}
	if(input_method == joystick)
	{
	    val = DB.joynames[? code];
	}
	if(input_method == gamepad)
	{
	    val = DB.padnames[? code];
	}

	if(val != undefined)
	{
	    return string(val);
	}
	else
	{
	    return "["+string(code)+"]";
	}



}
