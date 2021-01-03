function double_jump2_anim_set() {
    add_anim_step_display(1, 1, "text", "", "", 1, "Double Jump");
    add_anim_step_display(180, 0, "control", "jump", "click", 1, "PRESS", "in mid-air");
}
