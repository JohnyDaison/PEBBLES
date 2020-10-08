function status_haste_start() {
	old_running_maxspeed = self.running_maxspeed;
	old_running_power = self.running_power;

	my_sound_play(haste_sound);
	self.has_haste = true;



}
