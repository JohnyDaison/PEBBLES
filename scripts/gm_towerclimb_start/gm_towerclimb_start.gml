function gm_towerclimb_start() {
	with(gamemode_obj)
	{
	    levels_load_config("match");
	    config_level_gamemode("rewind", "", "", 0);
	    config_level_gamemode("teleport", "", "", 0); 
	}


}
