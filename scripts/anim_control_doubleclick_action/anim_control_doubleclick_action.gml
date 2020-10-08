function anim_control_doubleclick_action() {
	var time = argument[0];

	if(time >= 0 && time < 0.25)
	{
	    return "free";
	}
	if(time >= 0.25 && time < 0.45)
	{
	    return "held";
	}
	if(time >= 0.45 && time < 0.55)
	{
	    return "free";
	}
	if(time >= 0.55 && time < 0.75)
	{
	    return "held";
	}
	if(time >= 0.75 && time <= 1)
	{
	    return "free";
	}

	return "";



}
