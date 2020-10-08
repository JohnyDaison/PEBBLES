/// @description setprop(object, prop, value)
/// @function setprop
/// @param object
/// @param  prop
/// @param  value
function setprop() {
	var object = argument[0];
	var prop = argument[1];
	var value = argument[2];

	with(object)
	{
	    switch(prop)
	    {
	        case "invisible":
	            invisible = real(value);
	            break;   
	        case "speed":
	            speed = real(value);
	            break;
	        case "gravity":
	            gravity = real(value);
	            break;  
	        case "charge_ball":
	            charge_ball = parse_stringvalue("object", value);
	            break; 
	    }
	}

	return getprop(object, prop);




}
