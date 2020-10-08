function closed_quarters_joysticks() {
	fast_match_start(gamepad, 2);
	gamemode_obj.simple_mode = true;
	gamemode_obj.limits[? "score"] = 200;
	gamemode_obj.single_cam = gamemode_obj.world.current_place.single_cam;
	gamemode_obj.spawner_starting_damage = 5;
	gamemode_obj.spawner_shield_power = 2;
	//gamemode_obj.no_inventory = true;
	gamemode_obj.do_phenomena = false;
	/* too late
	with(player_obj)
	{
	    levels_roomstart[? "inventory"] = 0;
	    levels[? "inventory"] = 0;
	}
	*/
	//display_reset(0, true);



}
