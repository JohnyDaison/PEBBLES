function choose_body_color_anim_set() {
    add_anim_step_display(60, 0, "control", "blue", "click", 1, "PRESS ANY");
    add_anim_step_display(60, 0, "control", "green", "click", 1, "PRESS ANY");
    add_anim_step_display(60, 0, "control", "red", "click", 1, "PRESS ANY");
    add_anim_step_display(180, 0, "control", "cast", "press", 2, "PRESS");
    add_anim_step_display(180, 0, "empty", "", "", 1);
}
