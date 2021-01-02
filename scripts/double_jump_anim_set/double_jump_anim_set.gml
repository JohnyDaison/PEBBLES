function double_jump_anim_set() {
	add_anim_step_display(1, 1, "text", "", "", 1, "Double Jump");
	add_anim_step_display(90, 0, "control", "direction", "center", 1, "AIM");
	add_anim_step_display(90, 0, "control", "direction", "right", 1, "AIM");
	add_anim_step_display(10,  0, "pause", "", "", 1);
	add_anim_step_display(180, 0, "control", "jump", "doubleclick", 1, "DOUBLE PRESS");
	add_anim_step_display(180,  0, "empty", "", "", 1);
}
