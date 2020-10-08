function status_berserk_end() {
	if ((self.ball_chargerate - 1) > 0) {
	    self.ball_chargerate -= 1;
	}
	self.spell_cooldown = 10;
	self.shield_chargerate = 1;
	self.berserk = false;



}
