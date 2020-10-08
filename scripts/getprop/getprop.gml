/// @description getprop(object, prop)
/// @function getprop
/// @param object
/// @param  prop
function getprop() {
	var object = argument[0];
	var prop = argument[1];
	var ret = undefined;

	my_console_write("prop: "+ string(prop));
	with(object)
	{
	    switch(prop)
	    {
	        case "invisible":
	            ret = invisible;
	            break;   
	        case "speed":
	            ret = speed;
	            break;
	        case "gravity":
	            ret = gravity;
	            break; 
	        case "charge_ball":
	            ret = charge_ball;
	            break;
	    }
	    my_console_write(string(id) + ": "+ string(ret));   
    
	}

	return ret;



}
