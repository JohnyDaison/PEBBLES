function wall_climb_anim_set() {
	//add_anim_step_display(1, 0, "text", "heading", "", 1, "Wall Climb");
	add_anim_step_display(1, 1, "text", "", "", 1, "Wall Climb");
	add_anim_step_display(60, 0, "control", "direction", "center", 1, "AIM");
	add_anim_step_display(60, 0, "control", "direction", "right", 1, "AIM");
	add_anim_step_display(10, 0, "empty", "", "", 1);
	add_anim_step_display(120, 0, "control", "jump", "click", 1.5, "JUMP");
	add_anim_step_display(10, 0, "empty", "", "", 1);
	add_anim_step_display(120, 0, "control", "jump", "click", 1.5, "CLIMB");
	/*
	add_anim_step_display(15,  0, "empty", "", "", 1);
	add_anim_step_display(60, 0, "control", "jump", "click", 1, "JUMP");
	add_anim_step_display(15,  0, "empty", "", "", 1);
	add_anim_step_display(60, 0, "control", "jump", "click", 1, "CLIMB");
	*/
	add_anim_step_display(180, 0, "empty", "", "", 1);




}
