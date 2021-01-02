function destroy_anim_set() {
	clear_anim_set(true);

	ds_list_destroy(steps);
    ds_map_destroy(visible_steps_total);
}
