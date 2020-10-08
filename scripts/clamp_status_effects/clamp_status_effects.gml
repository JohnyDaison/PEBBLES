function clamp_status_effects() {
	var effect_id = ds_map_find_first(DB.status_effects);
	var effect;

	for(var i=0; i<DB.status_effect_count; i++)
	{
	    effect = DB.status_effects[? effect_id];
    
	    if(status_left[? effect_id] <= 0)
	    {
	        status_left[? effect_id] = 0;
	        if(status_start[? effect_id] != -1) {
	            script_execute(effect.end_script);
	            status_start[? effect_id] = -1;
	        }
	    }
	    else if(status_start[? effect_id] == -1) {
	        status_start[? effect_id] = step_count;
	        script_execute(effect.start_script);
	    }
    
	    if(status_left[? effect_id] > effect.max_charge)
	    {
	        status_left[? effect_id] = effect.max_charge;
	    }
    
	    effect_id = ds_map_find_next(DB.status_effects, effect_id);
	}



}
