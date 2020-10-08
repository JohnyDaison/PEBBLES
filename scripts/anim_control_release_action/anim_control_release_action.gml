function anim_control_release_action() {
	var time = argument[0];

	if(time >= 0 && time < 0.5)
	{
	    return "held";
	}
	if(time >= 0.5 && time <= 1)
	{
	    return "free";
	}

	return "";



}
