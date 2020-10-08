function match_force_finish() {
	gamemode_obj.reached_limit_name = "user_terminated";
	gamemode_obj.limit_reached = true;
	if(room==pausemenu)
	{
	    resume_game();
	}



}
