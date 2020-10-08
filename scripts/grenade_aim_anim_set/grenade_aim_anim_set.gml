function grenade_aim_anim_set() {
	add_anim_step_display(120, 0, "control", "inventory_2", "press", 2, "HOLD LEFT", "(D-PAD)");
	add_anim_step_display(120, 0, "control", "inventory_2", "hold", 2, "HOLD LEFT", "(D-PAD)");
	add_anim_step_display(60, 0, "control", "direction", "center", 1, "AIM");
	add_anim_step_display(60, 0, "control", "direction", "up", 1, "AIM");
	add_anim_step_display(180, 0, "control", "inventory_2", "release", 2, "RELEASE", "TO THROW");
	add_anim_step_display(180, 0, "empty", "", "", 1);


}
