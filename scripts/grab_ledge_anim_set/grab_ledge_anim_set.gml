function grab_ledge_anim_set() {
    add_anim_step_display(60, 0, "control", "direction", "centertoright", 1, "AIM");
    add_anim_step_display(180, 0, "control", "jump", "press", 1, "PRESS", "TO JUMP");
    add_anim_step_display(10, 0, "pause", "", "", 1);
    add_anim_step_display(180, 0, "control", "jump", "hold", 1, "HOLD", "TO GRAB\nTHE LEDGE");
    add_anim_step_display(10, 0, "pause", "", "", 1);
}
