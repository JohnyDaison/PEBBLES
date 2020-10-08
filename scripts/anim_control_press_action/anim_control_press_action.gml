function anim_control_press_action() {
	var time = argument[0];

	if(time >= 0 && time < 0.5)
	{
	    return "free";
	}
	if(time >= 0.5 && time <= 1)
	{
	    return "held";
	}

	return "";



}
