function abi_ubershield() {
    show_debug_message("ubershield used");
    var abi_color = g_purple;
    var success = false;
    
	if (has_level(id, "shield" , 1)) {
	    if (!instance_exists(my_shield) && my_color != g_black) {
	        var i = instance_create(x,y,shield_obj);
	        i.my_guy = id;
	        i.my_player = my_player;
	        i.max_charge = shield_max_charge;
	        i.size_coef = shield_size;
	        i.my_color = my_color;
	        my_shield = i;
	        shield_ready = true;
	    }
    
	    if (instance_exists(my_shield)) {
            status_left[? "ubershield"] += 420;
	        abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
            success = true;
	    }
	}
    
    if (!success) {
        my_sound_play(failed_sound);
        abi_cooldown_length[? abi_color] = 5;
	}
    
    return success;
}
