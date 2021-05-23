function use_invisibility_anim_set() {
    add_anim_step_display(180, 0, "control", "color", g_cyan, 1, "PICK", "CYAN");
    add_anim_step_display(120, 0, "control", "ability", "click", 2, "PRESS");
    add_anim_step_display(60, 0, "control", "ability", "free", 2, "PRESS");
    add_anim_step_display(180, 0, "empty", "", "", 1);
}
