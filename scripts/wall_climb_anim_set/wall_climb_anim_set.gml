function wall_climb_anim_set() {
    //add_anim_step_display(1, 0, "text", "heading", "", 1, "Wall Climb");
    add_anim_step_display(1, 1, "text", "", "", 1, "Wall Climb");
    
    add_anim_step_display(90, 0, "control", "direction", "centertoright", 1, "AIM");
    add_anim_step_display(10, 0, "pause", "", "", 1);
    
    add_anim_step_display(120, 0, "control", "jump", "click", 1.5, "JUMP");
    add_anim_step_display(10, 0, "pause", "", "", 1);
    add_anim_step_display(120, 0, "control", "jump", "click", 1.5, "CLIMB");

    add_anim_step_display(180, 0, "empty", "", "", 1);
}
