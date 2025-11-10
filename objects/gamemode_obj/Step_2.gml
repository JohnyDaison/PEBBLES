/// @description RULES, APM, RESTART

if (singleton_obj.paused || !self.game_started || self.game_ended) {
    exit;
}

var RuleID = global.RuleID;

// RULES
if (!rule_get_state(RuleID.BaseCrystals)) {
    // destroy crystals right after they spawn guys
    with (guy_obj) {
        var base = self.my_base;

        if (self.my_player == gamemode_obj.environment || !instance_exists(base)
            || base.object_index != guy_spawner_obj || base.destroyed) {
            continue;
        }

        if (instance_exists(base.my_shield)) {
            base.my_shield.done_for = true;
        }

        base.destroyed = true;
        base.visible = false;
        base.invisible = true;
        base.enabled = false;
        base.alarm[1] = -1;
        base.activated = false;
    }
}

if (!rule_get_state(RuleID.Turrets)) {
    with (turret_obj) {
        self.cancelled = true;
        instance_destroy();
    }
}

if (!rule_get_state(RuleID.Cannons)) {
    with (cannon_base_obj) {
        self.cancelled = true;
        instance_destroy();
    }
}

if (!rule_get_state(RuleID.MobPortals)) {
    with (mob_portal_obj) {
        instance_destroy();
    }
}

if (rule_get_state(RuleID.RandomItemSpawner)) {
    if (!instance_exists(pickup_spawner_obj)) {
        instance_create(0, 0, pickup_spawner_obj);
    }
}

if (!rule_get_state(RuleID.FlagCaptureScore)) {
    with (flag_spawner_obj) {
        self.cancelled = true;
        instance_destroy();
    }
}

// APM
if (instance_exists(self.time_window) && instance_exists(self.time_window.time)) {
    var minute = self.time_window.time.total div 60;

    if (self.last_minute != minute) {
        with (player_obj) {
            var apm = self.stats[? "actions"];
            set_stat(self.id, "actions", 0, false);

            if (self.stats[? "high_apm"] < apm) {
                set_stat(self.id, "high_apm", apm, false);
            }

            if (self.stats[? "low_apm"] == 0 || stats[? "low_apm"] > apm) {
                set_stat(self.id, "low_apm", apm, false);
            }
        }

        self.last_minute = minute;
    }
}

// RESTART
if (self.restart_match) {
    match_restart();
    self.restart_match = false;
}
