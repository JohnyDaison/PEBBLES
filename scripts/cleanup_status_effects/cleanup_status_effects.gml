function cleanup_status_effects() {
	var effect_id;
	for(var i=0; i<DB.status_effect_count; i++)
	{
	    effect_id = DB.status_effects_list[| i];
	    instance_destroy(status_particles[? effect_id]);
	}

	ds_map_destroy(status_left);
	ds_map_destroy(status_start);
	ds_map_destroy(status_particles);
}
