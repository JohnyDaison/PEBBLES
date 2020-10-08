function anim_control_click_action() {
	var time = argument[0];

	if(time >= 0 && time < 0.33)
	{
	    return "free";
	}
	if(time >= 0.33 && time < 0.66)
	{
	    return "held";
	}
	if(time >= 0.66 && time <= 1)
	{
	    return "free";
	}

	return "";



}
