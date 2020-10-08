function status_heal_step() {
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




}
