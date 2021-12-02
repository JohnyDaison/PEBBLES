function arena_bot1_init() {
    last_direction_change = 0
    direction_change_min_time = 30;
    sustain_tick_time = 60;
    attack_min_range = 96;
    third_attack_range = 164;
    difficulty = 1; //0.1 - 1
    flashback_margin = 512;

    spawn_batteries = true;

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

    name = "Arena bot v1";
}
