function dive_jump_anim_set() {
	add_anim_step_display(1, 1, "text", "", "", 1, "Dive Jump");
	add_anim_step_display(1, 2, "text", "", "", 1, "Dive Jump");
	add_anim_step_display(120, 0, "text", "", "", 1, "JUMP UP");
	add_anim_step_display(90, 0, "control", "direction", "center", 1, "AIM", "DOWN");
	add_anim_step_display(90, 0, "control", "direction", "down", 1, "AIM", "DOWN");
	add_anim_step_display(210, 0, "control", "jump", "press", 1.5, "PRESS JUMP", "in the air");
	add_anim_step_display(180,  0, "empty", "", "", 1);



}
