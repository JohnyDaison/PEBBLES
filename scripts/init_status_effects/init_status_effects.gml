function init_status_effects() {
	status_left = ds_map_create();
	status_start = ds_map_create();
	status_particles = ds_map_create();

	var effect_id = ds_map_find_first(DB.status_effects);

	for(var i=0; i < DB.status_effect_count; i++)
	{
	    status_left[? effect_id] = 0;
	    status_start[? effect_id] = -1;
	    status_particles[? effect_id] = noone;
    
	    effect_id = ds_map_find_next(DB.status_effects, effect_id);
	}

	burn_popup = noone;



}
