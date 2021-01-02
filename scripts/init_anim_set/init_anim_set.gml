function init_anim_set() {
    duration_total = 0;
    steps_total = 0;
    loop = true;
    anim_set_start = -1;

    steps = ds_list_create();
    visible_steps_total = ds_map_create();
}
