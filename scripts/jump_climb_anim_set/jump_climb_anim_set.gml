function jump_climb_anim_set() {
	add_anim_step_display(60, 1, "control", "direction", "center", 1, "AIM");
	add_anim_step_display(60, 1, "control", "direction", "right", 1, "AIM");
	add_anim_step_display(10, 1, "empty", "", "", 1);
    add_anim_step_display(120, 0, "control", "jump", "click", 1, "PRESS", "TO JUMP");
    add_anim_step_display(120, 1, "control", "jump", "press", 1, "HOLD", "TO CLIMB");
    add_anim_step_display(10, 1, "empty", "", "", 1);
}
