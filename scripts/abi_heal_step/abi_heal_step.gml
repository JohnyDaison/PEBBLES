function abi_heal_step() {
	var abi_color = g_green;

	var actual_heal = clamp(self.damage - self.min_damage, 0, heal_rate);
        
	if(actual_heal == heal_rate)
	{
	    self.damage -= heal_rate;
	}
	else
	{
	    self.damage = self.min_damage;
	}

	create_damage_popup(-actual_heal, heal_color, id, "heal");
	my_player.healed_dmg_total += actual_heal;

	abi_heal_total += heal_rate;    
    
	if(abi_heal_total >= max_heal)
	{
	    self.abi_script[? abi_color] = empty_script;
	    show_debug_message("heal finished");
	}



}
