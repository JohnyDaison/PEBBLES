function use_teleport_anim_set() {
	add_anim_step_display(180, 0, "control", "color", g_blue, 1, "PICK BLUE");
	add_anim_step_display(90, 0, "control", "direction", "center", 1, "AIM");
	add_anim_step_display(90, 0, "control", "direction", "right", 1, "AIM");
	add_anim_step_display(180, 0, "control", "ability", "click", 2, "PRESS");
	add_anim_step_display(180, 0, "empty", "", "", 1);
}
