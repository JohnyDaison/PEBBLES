function abi_haste() {
	show_debug_message("haste used");
	var abi_color = g_yellow;
    var success = true;

	status_left[? "haste"] += 490;

	abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
    
    return success;
}
