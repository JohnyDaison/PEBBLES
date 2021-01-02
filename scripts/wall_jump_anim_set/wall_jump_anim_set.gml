function wall_jump_anim_set() {
	add_anim_step_display(1, 1, "text", "", "", 0, "Wall Jump");
	add_anim_step_display(120, 0, "text", "", "", 0, "Climb the wall,", "then ...");
	add_anim_step_display(20,  0, "pause", "", "", 1);
	add_anim_step_display(60, 0, "control", "direction", "right", 1, "AIM LEFT");
	add_anim_step_display(60, 0, "control", "direction", "center", 1, "AIM LEFT");
	add_anim_step_display(60, 0, "control", "direction", "left", 1, "AIM LEFT");
	add_anim_step_display(20,  0, "pause", "", "", 1);
	add_anim_step_display(120, 0, "control", "jump", "click", 1.5, "JUMP");
	add_anim_step_display(180,  0, "empty", "", "", 1);
}
