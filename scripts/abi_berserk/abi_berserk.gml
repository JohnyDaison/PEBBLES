function abi_berserk() {
	my_console_log("berserk used");
	var abi_color = g_red;

	status_left[? "berserk"] += 420;

	abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
}
