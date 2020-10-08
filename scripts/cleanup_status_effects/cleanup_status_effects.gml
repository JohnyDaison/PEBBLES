function cleanup_status_effects() {
	var effect_id = ds_map_find_first(status_particles);
	while(!is_undefined(effect_id))
	{
	    instance_destroy(status_particles[? effect_id]);
    
	    effect_id = ds_map_find_next(status_particles, effect_id);
	}

	ds_map_destroy(status_left);
	ds_map_destroy(status_start);
	ds_map_destroy(status_particles);



}
