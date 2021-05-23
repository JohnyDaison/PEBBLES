function abi_flashback() {
    var abi_color = g_dark;
    var success = false;
    
    if(!flashback_disabled)
    {
        var old_state_exists = !is_undefined(self.flashback_queue[| 0]);
        var was_in_control = false;
    
        if(old_state_exists)
        {
            ds_map_read(old_state, self.flashback_queue[| 0]);
            was_in_control = !(old_state[? "lost_control"]);
        }
    
        if(old_state_exists && !self.flashing_back && was_in_control)
        {
            show_debug_message("flashback used");
            self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
            self.frozen_in_time = true;
            self.protected = true;
            self.flashing_back = true;
            self.time_rate = 3;
            my_sound_play(flashback_sound); 
        
            self.abi_script_delay[? abi_color] = 1;  
            self.abi_script[? abi_color] = abi_flashback_step;
            success = true;
        }
        else
        {
            self.abi_cooldown_length[? abi_color] = 1;
            my_sound_play(failed_sound);
        }
    }

    return success;
}
