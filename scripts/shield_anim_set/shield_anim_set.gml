function shield_anim_set() {
	add_anim_step_display(1, 1, "text", "", "", 1, "Color Shield");

	add_anim_step_display(180, 0, "text", "", "", 1, "PICK", "A COLOR");
	add_anim_step_display(180, 0, "control", "cast", "press", 2, "PRESS AND HOLD");
	add_anim_step_display(180, 0, "control", "cast", "release", 2, "RELEASE");
	add_anim_step_display(180, 0, "empty", "", "", 1);


}
