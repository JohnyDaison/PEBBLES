function abi_berserk_end() {
	var abi_color = g_red;

	if ((self.ball_chargerate - 1) > 0) {
	    self.ball_chargerate -= 1;
	}
	self.spell_cooldown = 10;
	self.shield_chargerate = 1;
	self.berserk = false;
	//berserk_flame.alarm[0] = 1;
	self.abi_script[? abi_color] = empty_script;
	show_debug_message("berserk finished");



}
