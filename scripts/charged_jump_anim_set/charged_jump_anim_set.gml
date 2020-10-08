function charged_jump_anim_set() {
	add_anim_step_display(240, 0, "control", "jump", "press", 1, "HOLD", "on the ground\nto charge jump");
	add_anim_step_display(180, 0, "control", "jump", "release", 1, "RELEASE", "to take off");
	add_anim_step_display(180, 0, "empty", "", "", 1);



}
