function abi_berserk() {
	my_console_log("berserk used");
	var abi_color = g_red;
    var success = true;

	status_left[? "berserk"] += 420;

	abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
    
    return success;
}
