function choose_body_color_anim_set() {
    add_anim_step_display(1, 1, "text", "", "", 1, "Choose Color");
    add_anim_step_display(60, 0, "control", "blue", "press", 1, "PRESS ONE OF");
    merge_anim_step_display(0);
    add_anim_step_display(60, 0, "control", "green", "press", 1, "PRESS ONE OF");
    merge_anim_step_display(0);
    add_anim_step_display(60, 0, "control", "red", "press", 1, "PRESS ONE OF");
    add_anim_step_display(180, 0, "control", "cast", "press", 2, "PRESS");
    add_anim_step_display(120, 0, "empty", "", "", 1);
}
