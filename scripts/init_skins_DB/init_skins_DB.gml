function init_skins_DB() {
    guy_skins = ds_map_create();
	//guy_skins[? "orig"] = ds_map_create();
	guy_skins[? "glowstick"] = ds_map_create();
	//guy_skins[? "blackbody"] = ds_map_create();
	var glowstick = guy_skins[? "glowstick"];

	glowstick[? "guy_stand"] = guy_stand;
	glowstick[? "guy_idle"] = guy_idle;
	glowstick[? "guy_walk"] = guy_walk;
	glowstick[? "guy_turn"] = guy_turn;
	glowstick[? "guy_run"] = guy_run;
	glowstick[? "guy_skid"] = guy_skid;
	glowstick[? "guy_hurt"] = guy_hurt;
	glowstick[? "guy_dead"] = guy_dead;
	glowstick[? "guy_jump"] = guy_jump;
	glowstick[? "guy_fall"] = guy_fall;
	glowstick[? "guy_gettingup"] = guy_gettingup;
	glowstick[? "guy_gettingdown"] = guy_gettingdown;
	glowstick[? "guy_flybackwards"] = guy_flybackwards;
	glowstick[? "guy_knockedback"] = guy_knockedback;
	glowstick[? "guy_knockedforward"] = guy_knockedforward;
	glowstick[? "guy_channeling"] = guy_channeling;
	glowstick[? "guy_charging"] = guy_charging;
	glowstick[? "guy_casting_forward"] = guy_casting_forward;
	glowstick[? "guy_casting_up"] = guy_casting_up;
	glowstick[? "guy_casting_down"] = guy_casting_down;
	glowstick[? "guy_crouch"] = guy_crouch;
	glowstick[? "guy_walljumphold"] = guy_walljumphold;
	glowstick[? "guy_wallclimbhold"] = guy_wallclimbhold;
	glowstick[? "guy_wallclimbup"] = guy_wallclimbup;
	glowstick[? "guy_flip"] = guy_flip;
	glowstick[? "guy_backflip"] = guy_backflip;
}