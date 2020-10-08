function gm_survival_start() {
	with(gamemode_obj)
	{
	    levels_load_config("match");
    
	    mob_spawners_first_delay = 30;
	    mob_spawners_respawn_delay = 120;
	}


}
