function abi_base_teleport() {
	show_debug_message("base teleport used");
	var abi_color = g_white;

	if(instance_exists(my_base) && !(my_base.object_index == guy_spawner_obj && my_base.destroyed))
	{
	    x = my_base.x;
	    y = my_base.y;
	    last_x = x;
	    last_y = y;
	    speed = 0;
	    self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
	    my_sound_play(base_tp_sound);
	}
	else
	{
	    self.abi_cooldown_length[? abi_color] = 1;
	    my_sound_play(failed_sound);
	}



}
