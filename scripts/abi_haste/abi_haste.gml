function abi_haste() {
	show_debug_message("haste used");
	old_running_maxspeed = self.running_maxspeed;
	old_running_power = self.running_power;
	var abi_color = g_yellow;

	my_sound_play(haste_sound);
	self.has_haste = true;

	self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
	self.abi_script_delay[? abi_color] = 490;
	self.abi_script[? abi_color] = abi_haste_end;



}
