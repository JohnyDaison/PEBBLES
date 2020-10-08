function grab_ledge_anim_set() {
	add_anim_step_display(60, 0, "control", "direction", "center", 1, "AIM");
	add_anim_step_display(120, 0, "control", "direction", "right", 1, "AIM");
	add_anim_step_display(180, 0, "control", "jump", "press", 1, "HOLD", "to grab\nthe ledge");


}
