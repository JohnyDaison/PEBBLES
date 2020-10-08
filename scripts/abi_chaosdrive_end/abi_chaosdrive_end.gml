function abi_chaosdrive_end() {
	effect_create_above(ef_firework,x,y,2,self.my_abi_tint);
	my_sound_play(chaos_sound);
	self.ball_chargerate *= (1+random(0.6)-0.3);
	self.ball_overcharge += (random(0.5)-0.25);
	self.abi_script = empty_script;
	show_debug_message("chaosdrive finished");



}
