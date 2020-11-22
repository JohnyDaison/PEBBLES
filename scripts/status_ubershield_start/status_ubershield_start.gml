function status_ubershield_start() {
    show_debug_message("status_ubershield_start");
    
	if (instance_exists(my_shield)) {
	    var ubershield = DB.status_effects[? "ubershield"];
            
        my_shield.charge = clamp(my_shield.charge * 2, my_shield.max_charge, shield_threshold); 
	    my_shield.overcharge += ubershield.shield_boost;
	    self.shield_overcharge += ubershield.shield_boost;
	    my_sound_play(ubershield_sound);
	} else {
	    status_left[? "ubershield"] = 0;
        status_start[? "ubershield"] = -1;
	}
}
