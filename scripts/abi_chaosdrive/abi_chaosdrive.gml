function abi_chaosdrive() {
	show_debug_message("chaosdrive activated");
	my_sound_play(chaos_sound);

	self.abi_cooldown = round(540);
	self.abi_script_delay = round(self.abi_cooldown-(random(420)+60));
	self.abi_script = abi_chaosdrive_end;



}
