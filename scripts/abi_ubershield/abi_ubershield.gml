function abi_ubershield() {
    show_debug_message("ubershield used");
    
    var failed = false;
    
	if (has_level(id, "shield" , 1)) {
	    var abi_color = g_purple;
        
	    if (!instance_exists(my_shield) && my_color != g_black) {
	        var i = instance_create(x,y,shield_obj);
	        i.my_guy = self.id;
	        i.my_player = self.my_player;
	        i.max_charge = self.shield_max_charge;
	        i.size_coef = self.shield_size;
	        i.my_color = self.my_color;
	        my_shield = i;
	        self.shield_ready = true;
	    }
    
	    if (instance_exists(my_shield)) {
            status_left[? "ubershield"] += 420;
	        self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
	    } else {
            failed = true;
	    }
	} else {
        failed = true;
    }
    
    if (failed) {
        my_sound_play(failed_sound);
        self.abi_cooldown_length[? abi_color] = 5;
	}
}
