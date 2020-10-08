function reset_status_effects() {
	var effect_id = ds_map_find_first(DB.status_effects);
	var effect;

	for(var i=0; i<DB.status_effect_count; i++)
	{
	    effect = DB.status_effects[? effect_id];

	    if(status_left[? effect_id] > 0 && status_start[? effect_id] != -1) {
	        script_execute(effect.end_script);
	        status_start[? effect_id] = -1;
	    }
	    status_left[? effect_id] = 0;
    
	    effect_id = ds_map_find_next(DB.status_effects, effect_id);
	}



}
