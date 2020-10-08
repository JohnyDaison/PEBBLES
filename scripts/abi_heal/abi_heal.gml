function abi_heal() {
	show_debug_message("heal used");
	my_sound_play(heal_sound);
	var abi_color = g_green;

	heal_rate = 0.2;
	max_heal = 1;
	abi_heal_total = 0;
	heal_color = my_color;
	self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
	if(instance_exists(my_base) && my_base.object_index == guy_spawner_obj && my_base.destroyed)
	{
	    self.abi_cooldown_length[? abi_color] *= 1/2;
	}
	self.abi_script_delay[? abi_color] = 60;
	self.abi_script[? abi_color] = abi_heal_step;
}
