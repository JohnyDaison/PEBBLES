if (!instance_exists(my_guy)) {
    exit;
}

// cooldown
if (cooldown_left > 0) {
    cooldown_left--;
}

ready_to_fire = active_time_left > 0 && cooldown_left == 0;

// activation
if (my_guy.wanna_cast && ready_to_fire) {
    active = true;
}

// deactivation
if (active) {
    if(!my_guy.wanna_cast || !ready_to_fire) {
        active = false;
        cooldown_left = min_cooldown_time + (max_active_time - active_time_left);
    }
}

// step
if (active) {
    active_time_left--;
    current_boost_ratio = min(1, current_boost_ratio + boost_change_rate);
} else {
    current_boost_ratio = max(0, current_boost_ratio - boost_change_rate);
    if(active_time_left < max_active_time) {
        active_time_left++;
    }
}

// apply boost
var shield = my_guy.my_shield;

shield.size_coef = 0.5 + 1 * current_boost_ratio;
shield.field_ratio = 0.75;
shield.field_power = 3 + 6 * current_boost_ratio;
