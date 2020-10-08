function classic_match_joysticks() {
	fast_match_start(gamepad, 0);
	gamemode_obj.simple_mode = true;
	gamemode_obj.limits[? "score"] = 200;
	gamemode_obj.spawner_starting_damage = 7;
	gamemode_obj.spawner_shield_power = 0;
	gamemode_obj.holographic_spawners = true;
	gamemode_obj.hp_death = false;
	gamemode_obj.weak_terrain = true;
	//gamemode_obj.no_inventory = true;
	gamemode_obj.do_phenomena = false;
	/* too late
	with(player_obj)
	{
	    levels_roomstart[? "inventory"] = 1;
	    levels[? "inventory"] = 1;
	}
	*/
	//display_reset(0, true);



}
