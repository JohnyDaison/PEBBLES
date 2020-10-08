function aim_shot_anim_set() {
	add_anim_step_display(1, 1, "control", "move_lock", "hold", 1, "Movement Lock");
	add_anim_step_display(90, 0, "control", "look", "press", 1, "PUSH AND HOLD", "to LOCK");
	add_anim_step_display(90, 0, "control", "look", "hold", 1, "PUSH AND HOLD", "to LOCK");
	add_anim_step_display(60, 0, "control", "direction", "aim", 1, "AIM", "while LOCKED");
	add_anim_step_display(120, 0, "control", "direction", "aimright", 1, "AIM", "while LOCKED");
	/*
	add_anim_step_display(180, 0, "control", "cast", "click", 2, "CHARGE AND FIRE!");
	*/
	add_anim_step_display(180, 0, "empty", "", "", 1);



}
