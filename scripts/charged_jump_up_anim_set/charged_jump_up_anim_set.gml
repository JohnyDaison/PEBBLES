function charged_jump_up_anim_set() {
	add_anim_step_display(1, 1, "text", "", "", 1, "Charged Jump");
	//add_anim_step_display(180, 0, "control", "direction", "center", 1, "For extra jump height:", "Don't MOVE");
	//add_anim_step_display(180, 0, "text", "", "", 1, "For extra jump height", "stand still, then ...");
	add_anim_step_display(180, 0, "control", "jump", "press", 1, "HOLD", "until crouched");
	add_anim_step_display(10, 0, "pause", "", "", 1);
	add_anim_step_display(180, 0, "control", "jump", "release", 1, "RELEASE");
	add_anim_step_display(180, 0, "empty", "", "", 1);
}
