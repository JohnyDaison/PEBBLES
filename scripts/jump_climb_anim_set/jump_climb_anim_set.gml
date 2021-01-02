function jump_climb_anim_set() {
	add_anim_step_display(60, 1, "control", "direction", "center", 1, "AIM");
	add_anim_step_display(60, 1, "control", "direction", "right", 1, "AIM");
	add_anim_step_display(10, 1, "pause", "", "", 1);
    add_anim_step_display(120, 1, "control", "jump", "press", 1.5, "PRESS", "TO JUMP");
    add_anim_step_display(120, 1, "control", "jump", "hold", 1.5, "HOLD", "TO CLIMB");
    add_anim_step_display(10, 1, "pause", "", "", 1);
}
