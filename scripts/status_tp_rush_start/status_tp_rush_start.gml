function status_tp_rush_start() {
	has_tp_rush = true;

	set_my_color(g_blue);
	if(instance_exists(charge_ball))
	{
	    with(charge_ball)
	    {
	        event_perform(ev_alarm, 2);
	    }
	}

	if(abi_cooldown[? g_blue] > 1)
	{
	    abi_cooldown[? g_blue] = 1;
	    teleport_uses_left = get_level(id, "teleport");
	}



}
