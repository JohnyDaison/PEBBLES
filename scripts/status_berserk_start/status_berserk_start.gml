function status_berserk_start() {
	my_sound_play(berserk_sound);
	self.ball_chargerate += 1;
	self.spell_cooldown = 5;
	self.shield_chargerate = 0;
	self.berserk = true;

	my_console_log(object_get_name(object_index));
	my_console_log("berserk started");


}
