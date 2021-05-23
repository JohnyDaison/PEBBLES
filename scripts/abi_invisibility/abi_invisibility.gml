function abi_invisibility() {
    show_debug_message("invisibility used");
    var abi_color = g_cyan;
    var success = true;    
    
    status_left[? "invisibility"] += 360;
    
    abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
    
    return success;
}
