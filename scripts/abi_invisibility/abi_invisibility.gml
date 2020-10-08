function abi_invisibility() {
	show_debug_message("invisibility used");
	var abi_color = g_azure;
	my_sound_play(invis_sound);
	visible = false;
	self.invisible = true;
	self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
	self.abi_script_delay[? abi_color] = 360;

	self.abi_script[? abi_color] = abi_invisibility_end;



}
