var RuleID = global.RuleID;

spawn_active[? "snake"] = rule_get_state(RuleID.Snakes) && singleton_obj.step_count > snake_grace_period;
spawn_active[? "artifact"] = rule_get_state(RuleID.Artifacts);
spawn_active[? "star_core"] = gamemode_obj.star_fall && singleton_obj.step_count > starfall_grace_period;
spawn_active[? "slime_mob"] = rule_get_state(RuleID.SlimeMobRain);

// Bolt rain start/stop
if(rule_get_state(RuleID.BoltRain) && singleton_obj.step_count > bolt_rain_grace_period)
{
    if(!bolt_rain_started)
    {
        if(singleton_obj.step_count >= (bolt_rain_start_step + bolt_rain_duration + bolt_rain_pause))
        {
            bolt_rain_started = true;
            spawn_active[? "small_bolt"] = true;
            bolt_rain_start_step = singleton_obj.step_count;
        }
    }
    else
    {
        if(singleton_obj.step_count >= bolt_rain_start_step + bolt_rain_duration)
        {
            bolt_rain_started = false;
            spawn_active[? "small_bolt"] = false;
        }   
    }
}


// Lightning strikes start/stop
if(rule_get_state(RuleID.LightningStrikes) && singleton_obj.step_count > lightning_strikes_grace_period)
{
    if(!lightning_strikes_started)
    {
        if(singleton_obj.step_count >= (lightning_strikes_start_step + lightning_strikes_duration + lightning_strikes_pause))
        {
            lightning_strikes_started = true;
            spawn_active[? "lightning_strike"] = true;
            lightning_strikes_start_step = singleton_obj.step_count;
        }
    }
    else
    {
        if(singleton_obj.step_count >= lightning_strikes_start_step + lightning_strikes_duration)
        {
            lightning_strikes_started = false;
            spawn_active[? "lightning_strike"] = false;
        }   
    }
}

spawn_delay_ratio = 1;

if(bolt_rain_started)
{
    spawn_delay_ratio = bolt_rain_delay_ratio;
}
else if(lightning_strikes_started)
{
    spawn_delay_ratio = lightning_strikes_delay_ratio;
}


spawn_delay = ceil(base_spawn_delay * spawn_delay_ratio);

if(alarm[0] > spawn_delay)
{
    alarm[0] = spawn_delay;
}