function cannon_anim_set() {
	add_anim_step_display(120, 0, "control", "direction", "center", 1, "AIM");
	add_anim_step_display(120, 0, "control", "direction", "up", 1, "AIM");
	add_anim_step_display(180, 0, "control", "cast", "hold", 2, "HOLD", "TO ALIGN");
	add_anim_step_display(180, 0, "control", "alt_fire", "press", 2, "PRESS", "TO AUTOFIRE");
	add_anim_step_display(180, 0, "empty", "", "", 1);



}
