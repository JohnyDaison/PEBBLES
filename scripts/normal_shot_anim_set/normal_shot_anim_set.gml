function normal_shot_anim_set() {
	add_anim_step_display(120, 0, "control", "green", "click", 1, "PRESS");
	add_anim_step_display(120, 0, "control", "cast", "press", 2, "PRESS AND HOLD");
	add_anim_step_display(60, 0, "control", "direction", "center", 1, "AIM");
	add_anim_step_display(60, 0, "control", "direction", "right", 1, "AIM");
	add_anim_step_display(120, 0, "control", "cast", "release", 2, "RELEASE");
	add_anim_step_display(150, 0, "empty", "", "", 1);



}
