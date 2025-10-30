/// @description RULES, APM, RESTART

if(!singleton_obj.paused && game_started && !game_ended)
{
    var RuleID = global.RuleID;

    // RULES
    if(!rule_get_state(RuleID.BaseCrystals))
    {
        // destroy crystals right after they spawn guys
        with(guy_obj)
        {
            if(my_player != gamemode_obj.environment && instance_exists(my_base) 
            && my_base.object_index == guy_spawner_obj && !my_base.destroyed)
            {
                with(my_base)
                {
                    destroyed = true;
                    if(instance_exists(my_shield))
                    {
                        my_shield.done_for = true;
                    }
                    self.visible = false;
                    self.invisible = true;
                    self.enabled = false;
                    alarm[1] = -1;
                    self.activated = false;
                }
            }
        }
    }

    if(!rule_get_state(RuleID.Turrets))
    {
        with(turret_obj)
        {
            cancelled = true;
            instance_destroy();
        }
    }

    if(!rule_get_state(RuleID.Cannons))
    {
        with(cannon_base_obj)
        {
            cancelled = true;
            instance_destroy();
        }
    }

    if(!rule_get_state(RuleID.MobPortals))
    {
        with(mob_portal_obj)
        {
            instance_destroy();
        }   
    }

    if(rule_get_state("random_item_spawner"))
    {
        if(!instance_exists(pickup_spawner_obj))
        {
            instance_create(0,0, pickup_spawner_obj);
        }
    }
    
    if(!rule_get_state("flag_capture"))
    {
        with(flag_spawner_obj)
        {
            cancelled = true;
            instance_destroy();
        }
    }

    // APM
    if (instance_exists(time_window) && instance_exists(time_window.time)) {
        var minute = time_window.time.total div 60;
    
        if (last_minute != minute) {
            with (player_obj) {
                var apm = stats[? "actions"];
                set_stat(id, "actions", 0, false);
        
                if (stats[? "high_apm"] < apm) {
                    set_stat(id, "high_apm", apm, false);
                }
        
                if (stats[? "low_apm"] == 0 || stats[? "low_apm"] > apm) {
                    set_stat(id, "low_apm", apm, false);
                }
            }

            last_minute = minute;
        }
    }

    // RESTART
    if (restart_match) {
        match_restart();
        restart_match = false;
    }
}
