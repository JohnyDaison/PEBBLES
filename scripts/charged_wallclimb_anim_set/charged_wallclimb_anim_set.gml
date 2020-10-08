function charged_wallclimb_anim_set() {
	add_anim_step_display(      40, 0,      "control", "direction", "right", 1);
	add_anim_step_display(      40, 0,      "control", "jump", "click", 1);

	add_anim_step_connection(   15, 0, 1,   "anim", "small_dot", "default", 1);
	add_anim_step_display(      1, 0,       "empty", "", "", 1);

	add_anim_step_display(      40, 1,      "control", "direction", "right", 1);
	add_anim_step_display(      40, 1,      "control", "jump", "click", 1);

	add_anim_step_connection(   15, 1, 2,   "anim", "small_dot", "default", 1);
	add_anim_step_display(      1, 1,       "empty", "", "", 1);

	add_anim_step_display(      40, 2,      "control", "direction", "right", 1);
	add_anim_step_display(      40, 2,      "control", "jump", "click", 1);

	add_anim_step_connection(   15, 2, 3,   "anim", "small_dot", "default", 1);
	add_anim_step_display(      1, 2,       "empty", "", "", 1);

	add_anim_step_display(      80, 3,      "control", "direction", "left", 1);
	add_anim_step_display(      40, 3,      "control", "jump", "click", 1);

	var i = 3;
	repeat(5)
	{
	    add_anim_step_connection(   3, i, i+1,  "anim", "small_dot", "default", 1);
	    add_anim_step_display(      1, i,       "empty", "", "", 1);
	    i++;
	}

	add_anim_step_display(      40, 9,      "control", "jump", "click", 1);

	add_anim_step_display(      10, 9,      "empty", "", "", 1);



}
