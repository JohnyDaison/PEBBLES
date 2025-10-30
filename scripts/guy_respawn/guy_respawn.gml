function guy_respawn() {
    var RuleID = global.RuleID;

    if(dead && !respawn_allowed())
    {
        my_player.loser = true;
        ds_list_add(gamemode_obj.losers, my_player.id);
    }

    if(instance_exists(my_spawner) && my_spawner.enabled && respawn_allowed())
    {   
        var point = my_spawner.spawn_points[? my_player.number];
    
        if(!point.activated)
        {
            my_console_log("SPAWN POINT FOR " + string(my_player.name) + " WAS NOT ACTIVATED!");
            return;
        }
    
        x = point.x;
        y = point.y;
        last_x = x;
        last_y = y;
        speed = 0;
        damage = min_damage;
        lost_control = true;
        got_up = true;
        protected = true;
        mask_index = guy_stand;
        visible = true;
        invisible = false;
        dead = false;
        ready_to_die = false;
        if(instance_exists(my_player.my_camera))
        {
            my_player.my_camera.death_cover_show = false;
        } 
        shield_chargerate = 1;
        shield_overcharge = 0;
        ball_chargerate = base_ball_chargerate;
        warmed = 0;
        ball_overcharge = 0;
        shield_ready = true;
    
        color_charge[? g_red] = 0;
        color_charge[? g_green] = 0;
        color_charge[? g_blue] = 0;
        potential_charge[? g_red] = 0;
        potential_charge[? g_green] = 0;
        potential_charge[? g_blue] = 0;
    
        /*
        energy_left[g_dark] = energy_max[g_dark];
        energy_left[g_red] = energy_max[g_red];
        energy_left[g_green] = energy_max[g_green];
        energy_left[g_blue] = energy_max[g_blue];
        */ 
        reset_status_effects();
    
        ds_list_clear(flashback_queue);
    
        if(rule_get_state(RuleID.DarkColor))
        {
            set_my_color(g_dark);
            tint_updated = false;
            slots_absorbed = 0;
        
            if(instance_exists(charge_ball))
            {
                //chargeball_orbs_return(charge_ball);
                charge_ball.alarm[2] = 1;
            
                charge_ball.my_color = g_dark;
                charge_ball.tint_updated = false;
            }
        }
    
        potential_color = my_color;
    
        if(instance_exists(charge_ball))
        {
            charge_ball.x = x;
            charge_ball.y = y;
        }
    
        current_slot = 0;
    
        orb_reserve[? g_red] = 0;
        orb_reserve[? g_green] = 0;
        orb_reserve[? g_blue] = 0;
    
        guy_orbs_reset(id);
    
        instance_create(x,y,spawn_effect_obj);
    
        if(instance_exists(my_player.my_camera))
        {
            my_player.my_camera.follow_guy = true;
            my_player.my_camera.follow_spawner = false;
        }
    
        if(my_spawner.object_index == guy_spawner_obj)
        {
            var guy = id;
            alarm[2] = my_spawner.protection_time;
            
            with(my_spawner)
            {
                damage += 1;
                last_attacker_update(guy, "body", "damage");
            }
        }
        else
        {
            alarm[2] = protection_time;
        }
    }
}
