function use_ability_anim_set() {
	add_anim_step_display(180, 0, "text", "", "", 1, "PREPARE", "THE RIGHT COLOR");
	add_anim_step_display(120, 0, "control", "ability", "click", 2, "PRESS","to use Ability");
	add_anim_step_display(60, 0, "control", "ability", "free", 2, "PRESS","to use Ability");
	add_anim_step_display(180, 0, "empty", "", "", 1);
}
