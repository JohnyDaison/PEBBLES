function quick_shot_anim_set() {
    add_anim_step_display(1, 1, "text", "", "", 1, "Blast");
    add_anim_step_display(180, 0, "control", "cast", "press", 2, "HOLD", "TO CHARGE");
    add_anim_step_display(120, 0, "control", "direction", "centertoup", 1, "AIM");
    add_anim_step_display(180, 0, "control", "cast", "release", 2, "RELEASE");
    add_anim_step_display(120, 0, "empty", "", "", 1);
}
