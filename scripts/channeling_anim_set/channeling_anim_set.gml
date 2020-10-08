function channeling_anim_set() {
	add_anim_step_display(1, 1, "text", "", "", 1, "Channeling");
	add_anim_step_display(180, 0, "text", "", "", 1, "PICK SOME\nCOLORS");
	add_anim_step_display(180, 0, "control", "channel", "press", 2, "HOLD", "TO DRAIN ENERGY");
	add_anim_step_display(180, 0, "control", "channel", "hold", 2, "HOLD", "TO DRAIN ENERGY");
	add_anim_step_display(180, 0, "empty", "", "", 1);



}
