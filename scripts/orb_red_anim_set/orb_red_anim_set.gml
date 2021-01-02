function orb_red_anim_set() {
	add_anim_step_display(180, 0, "control", "red", "click", 1, "PRESS", "to select");
	add_anim_step_display(60, 0, "pause", "", "", 1);
	add_anim_step_display(180, 0, "control", "cast", "click", 2, "PRESS", "to absorb");
	add_anim_step_display(60, 0, "empty", "", "", 1);
}
