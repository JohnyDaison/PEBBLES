function arena_bot3_init() {
    bot_type = "arena_bot";

    last_direction_change = 0
    direction_change_min_time = 30;
    sustain_tick_time = 60;
    attack_min_range = 96;
    third_attack_range = 32*9;
    vortex_range = 32*10;
    difficulty = 1; //0.1 - 1
    bot_speed = 1;
    bot_complexity = 1;
    bot_aggressiveness = 1;
    flashback_margin = 384;
    attack_mode = false;
    color_chosen = false;
    prev_phase = -1;
    next_phase = phase;
    attack_target = noone;
    move_target = noone;
    //safe_channeling = true;

    npc_wanna_shoot_dark = false;
    npc_wanna_shoot_dark_decided = false;

    shard_pickup_range = 24 * 32;

    // CHARGEBALL
    guy_provide_chargeball(id);
    /*
    if(has_level(id, "chargeball", 1))
    {
        if(!instance_exists(charge_ball))
        {
            ii = instance_create(x,y,charge_ball_obj);
            ii.my_guy = id;
            ii.my_player = self.my_player;
            charge_ball = ii;
        }
    }
    */
    npc_guy2_init();

    name = "Arena bot v3";
}
