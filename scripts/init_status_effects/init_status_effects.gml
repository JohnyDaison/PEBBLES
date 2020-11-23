function init_status_effects() {
	status_left = ds_map_create();
	status_start = ds_map_create();
	status_particles = ds_map_create();

	var effect_id;

	for(var i=0; i < DB.status_effect_count; i++)
	{
	    effect_id = DB.status_effects_list[| i];
        
        status_left[? effect_id] = 0;
	    status_start[? effect_id] = -1;
	    status_particles[? effect_id] = noone;
	}

	burn_popup = noone;
    heal_popup = noone;
}
