function status_heal_step() {
    var heal = DB.status_effects[? "heal"];
	var actual_heal = clamp(self.damage - self.min_damage, 0, heal.hp_tick);

	if(actual_heal == heal.hp_tick)
	{
	    self.damage -= heal.hp_tick;
	}
	else
	{
	    self.damage = self.min_damage;
	}

    // DAMAGE POPUP
	if(!instance_exists(heal_popup))
	{
	    heal_popup = create_damage_popup(-actual_heal, heal.color, id, "heal");
	    heal_popup.visible = false;
	}
	else
	{
	    with(heal_popup)
	    {
	        x = other.x;
	        y = other.bbox_top;
	        damage -= actual_heal;
	        fade_ratio = 0.6;
	        alarm[0] = life_length - fade_in_length;
	    }
	}
    
    my_player.healed_dmg_total += actual_heal;
}
