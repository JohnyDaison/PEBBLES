function abi_berserk() {
	my_console_log("berserk used");
	my_sound_play(berserk_sound);
	var abi_color = g_red;

	/*
	self.ball_chargerate += 1;
	self.spell_cooldown = 5;
	self.shield_chargerate = 0;
	self.berserk = true;
	berserk_flame = instance_create(x,y,berserk_flame_obj);
	berserk_flame.my_guy = self.id;
	*/
	my_guy.status_left[? "berserk"] += 420;

	abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
	/*
	self.abi_script_delay[? abi_color] = 420;
	self.abi_script[? abi_color] = abi_berserk_end;
	*/



}
