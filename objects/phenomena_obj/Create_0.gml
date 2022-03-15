// GENERAL
base_spawn_delay = 1200; //1800 //600;
spawn_delay = base_spawn_delay; 
spawn_delay_ratio = 1;
hor_margin = 160;
ver_margin = 160;
slots_enabled = false;
my_guy = noone;
my_player = gamemode_obj.environment;
holographic = false;

// GRACE PERIODS
snake_grace_period = 5*3600; //5m
bolt_rain_grace_period = 1*3600; //1m //10m
starfall_grace_period = 20*3600; //20m
lightning_strikes_grace_period = 3*3600; //3m

// BOLT RAIN
bolt_rain_started = false;
bolt_rain_duration = 40*60; // 40s
bolt_rain_pause = 30*60; // 30s
bolt_rain_start_step = -bolt_rain_duration -bolt_rain_pause;
bolt_rain_delay_ratio = 1/60; // every 20 steps

// LIGHTNING STRIKES
lightning_strikes_started = false;
lightning_strikes_duration = 40*60; // 40s
lightning_strikes_pause = 50*60; // 50s
lightning_strikes_start_step = -lightning_strikes_duration -lightning_strikes_pause;
lightning_strikes_delay_ratio = 1/30; // every 40 steps
lightning_strikes_prob_ratio = 0.35;

// SLIME MOBS
slime_mob_count = 4;

// SPAWNABLES
spawnables = ds_list_create();
var i = 0, count;

spawnables[|i++] = "snake";
spawnables[|i++] = "star_core";
spawnables[|i++] = "slime_mob";
spawnables[|i++] = "artifact";
spawnables[|i++] = "lightning_strike";
spawnables[|i++] = "small_bolt";

count = i;

// SPAWNABLES - PROBABILITY PERCENT
spawn_ratio = ds_map_create();

spawn_ratio[? "snake"] = 2; //1
spawn_ratio[? "star_core"] = 2; //1
spawn_ratio[? "slime_mob"] = 1; //1
spawn_ratio[? "artifact"] = 5; //10
spawn_ratio[? "lightning_strike"] = 100; //1
spawn_ratio[? "small_bolt"] = 100; //95

// SPAWNABLES - ACTIVE
spawn_active = ds_map_create();

for(i=0; i < count; i++)
{
    spawn_active[? (spawnables[|i])] = false;
}

alarm[0] = spawn_delay;
