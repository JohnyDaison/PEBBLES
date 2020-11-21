function abi_heal() {
	show_debug_message("heal used");
	my_sound_play(heal_sound);
	var abi_color = g_green;

	self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
	if(instance_exists(my_base) && my_base.object_index == guy_spawner_obj && my_base.destroyed)
	{
	    self.abi_cooldown_length[? abi_color] *= 1/2;
	}
    
    self.status_left[? "heal"] += 300;
}
