function charged_triple_jump_anim_set() {
	var i = 0;
	add_anim_step_display(      20, i,      "control", "jump", "press", 1);
	add_anim_step_connection(   40, i, i+1,   "control", "jump", "hold", 1);

	add_anim_step_display(      1, i+1,       "control", "jump", "hold", 1);
	add_anim_step_display(      1, i,       "empty", "", "", 1);
	i++;
	add_anim_step_display(      30, i,      "control", "jump", "release", 1);
	add_anim_step_connection(   15, i, i+1,   "anim", "small_dot", "default", 1);
	add_anim_step_display(      1, i,      "empty", "", "", 1);
	i++;
	add_anim_step_connection(   15, i, i+1,   "anim", "small_dot", "default", 1);
	add_anim_step_display(      1, i,      "empty", "", "", 1);
	i++;
	add_anim_step_display(      30, i,      "control", "jump", "click", 1);
	add_anim_step_connection(   15, i, i+1,   "anim", "small_dot", "default", 1);
	add_anim_step_display(      1, i,      "empty", "", "", 1);
	i++;
	add_anim_step_connection(   15, i, i+1,   "anim", "small_dot", "default", 1);
	add_anim_step_display(      1, i,      "empty", "", "", 1);
	i++;
	add_anim_step_display(      30, i,      "control", "jump", "click", 1);
	add_anim_step_connection(   15, i, i+1,   "anim", "small_dot", "default", 1);
	add_anim_step_display(      1, i,      "empty", "", "", 1);
	i++;
	add_anim_step_connection(   15, i, i+1,   "anim", "small_dot", "default", 1);
	add_anim_step_display(      60, i,      "empty", "", "", 1);



}
