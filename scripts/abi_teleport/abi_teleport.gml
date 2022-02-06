function abi_teleport() {
    show_debug_message("teleport used");
    var abi_color = g_blue;
    var abi_level = get_level(id, "teleport");
    var success = false;

    if(abi_cooldown_length[? abi_color] == DB.abi_cooldowns[? abi_color])
    {
        teleport_uses_left = abi_level;
    }

    if(self.has_tp_rush || teleport_uses_left > 1)
    {
        self.abi_cooldown_length[? abi_color] = 1;
    }
    else
    {
        self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
    }


    if(desired_aim_dist > 0)
    {
        var result = compute_blink_position(desired_aim_dir);
    
        if(result[? "dist"] > 0)
        {
            success = true;
        }
    }

    if(!success)
    {
        self.abi_cooldown_length[? abi_color] = 1;
        my_sound_play(failed_sound);
    }

    if(success)
    {
        drop_enemy_flags();
        
        pre_tp_x = x;
        pre_tp_y = y;
        
        x = result[? "x"];
        y = result[? "y"];
    
        last_x = x;
        last_y = y;
        speed = 0;
    
        self.has_tped = true;
        my_sound_play(tp_sound);
    
        if(teleport_uses_left == abi_level)
        {
            teleport_first_use_step = step_count;
        }
    
        if(has_tp_rush)
        {
            teleport_uses_left = abi_level;
        }
        else
        {
            teleport_uses_left--;
        }
    }

    return success;
}
