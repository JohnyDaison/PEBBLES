function abi_heal() {
	show_debug_message("heal used");
	var abi_color = g_green;
    
    status_left[? "heal"] += 300;

	abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
	if(instance_exists(my_base) && my_base.object_index == guy_spawner_obj && my_base.destroyed)
	{
	    abi_cooldown_length[? abi_color] *= 1/2;
	}
}
