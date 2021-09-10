function init_skins_DB() {
    guy_skins = ds_map_create();
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
    
    guy_skins[? "biker"] = ds_map_create();
    var biker = guy_skins[? "biker"];

    biker[? "guy_stand"] = guy_stand_biker;
    biker[? "guy_idle"] = guy_idle_biker;
    biker[? "guy_walk"] = guy_walk_biker;
    biker[? "guy_turn"] = guy_turn;
    biker[? "guy_run"] = guy_run_biker;
    biker[? "guy_skid"] = guy_skid_biker;
    biker[? "guy_hurt"] = guy_hurt_biker;
    biker[? "guy_dead"] = guy_dead_biker;
    biker[? "guy_jump"] = guy_jump_biker;
    biker[? "guy_fall"] = guy_fall_biker;
    biker[? "guy_gettingup"] = guy_gettingup_biker;
    biker[? "guy_gettingdown"] = guy_gettingdown_biker;
    biker[? "guy_flybackwards"] = guy_flybackwards_biker;
    biker[? "guy_knockedback"] = guy_knockedback_biker;
    biker[? "guy_knockedforward"] = guy_knockedforward_biker;
    biker[? "guy_channeling"] = guy_channeling_biker;
    biker[? "guy_charging"] = guy_charging_biker;
    biker[? "guy_casting_forward"] = guy_casting_forward_biker;
    biker[? "guy_casting_up"] = guy_casting_up_biker;
    biker[? "guy_casting_down"] = guy_casting_down_biker;
    biker[? "guy_crouch"] = guy_crouch_biker;
    biker[? "guy_walljumphold"] = guy_walljumphold_biker;
    biker[? "guy_wallclimbhold"] = guy_wallclimbhold_biker;
    biker[? "guy_wallclimbup"] = guy_wallclimbup_biker;
    biker[? "guy_flip"] = guy_flip_biker;
    biker[? "guy_backflip"] = guy_backflip;
}