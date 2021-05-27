event_inherited();

my_spawner = noone;
my_base = noone;
my_guy = id;
my_skin = DB.guy_skins[? "glowstick"];
my_chunkgrid = noone;
observer_range = 1;
depth = -3;

// TERRAIN OPTIMIZATION
read_terrain = true;
self.ter_right = 1;
self.ter_left = 1;
self.ter_up = 1;
self.ter_down = 1;

// NPCs
is_npc = false;
flashback_disabled = false;
flashback_inited = false;
phase = 0;
last_phase = phase;
npc_active = false;
npc_script = empty_script;
npc_destroy_script = empty_script;
last_damage = 0;
steps_waited = 0;

//debug
attack_waypoints = ds_list_create();

speech_init();

// PARAMETERS

// HP
self.normal_hp = 10;
self.hp = normal_hp;
self.dead = false;
self.min_damage = 0;

function drop_reserve_orbs() {
    guy_drop_reserve_orbs();
}

function die_from_damage() {
    guy_die_from_damage();
}

function die_from_falling() {
    guy_die_from_falling();
}


init_equipment_sys();

add_hardpoint(0,0, hp_shield);
add_hardpoint(0,0, hp_shield);
add_hardpoint(0,0, hp_shield);
add_hardpoint(0,0, hp_weapon);


// LOST CONTROL TRIGGERING
self.lost_control_boost_threshold = 6;
self.lost_control_damage_threshold = 1.25;

// DURATION
knockout_duration = 30;
recover_time = 120;
hurt_duration = 60;
spell_cooldown = 10;
step_frequency = 150;
deathwish_warmup_time = 360;
walljump_grace = 30;
walljump_wait = 90;
protection_time = 10;

// SHIELD, CHARGEBALL SETTINGS
self.shield_max_charge = 1;
self.shield_size = 1;
self.shield_chargerate = 1;
self.shield_overcharge = 0;
self.shield_channel_maxboost = 0.5;
self.shield_threshold = 3;
self.shield_repair_time = 180;
self.ball_chargerate = 1;
self.base_ball_chargerate = 1;
self.ball_overcharge = 0;

self.auto_choose_channel_orbs = true;
self.auto_choose_channel_orbs_delay = 10;
self.auto_chosen_orbs = false;

//ENERGY
/*
energy_max[g_dark] = 40;
energy_max[g_red] = 20;
energy_max[g_green] = 20;
energy_max[g_blue] = 20;
energy_regen = true;
energy_regen_rate = 0.001;
regen_coef = 1;
*/

// MOVEMENT
self.running_power = 0.2;
self.running_maxspeed = 5;
self.slowed_maxspeed = 1.5;
self.running_slow_mod = 0.75;
self.running_haste_mod = 2;
self.max_walking_speed = 1.5;

self.jumping_burstpower = 9;
self.jumping_divepower = 4;
self.jumping_glidepower = 0.1;
self.jumping_origin = 0;
self.jumping_max_height = 0;
self.jumping_normal_height = 320;
self.jumping_wall_height = 96;

//self.jumping_normal_flippower = 5;

self.jumping_normal_charge = 12;
self.jumping_max_charge = self.jumping_normal_charge;

self.jumping_normal_charge_speed = 0.36;
self.jumping_charge_speed = self.jumping_normal_charge_speed;

self.jumping_charged_base_charge = 10*jumping_charge_speed;
self.jumping_normal_base_charge = 16*jumping_charge_speed;

self.jumping_slow_mod = 0.75;
self.jumping_bounce_mod = 1.25;
self.jumping_haste_mod = 1.5;

self.dive_threshold = 10;
self.impact_speed = 16;
self.max_speed = 40;
self.action_rate = 6;
self.max_doublejumps = 0;
self.skid_speed = 2;
self.max_walkup_step = 10;

self.hor_aim_fix = 5; // 10
self.ver_aim_fix = 5;

self.levels_inited = false;

//self.walljump_max_charge = 5;

self.gravity_coef = 0.38;
old_coef = 0;
self.gravity_direction = 270;
self.friction = 0.07;
self.orig_friction = self.friction;
self.last_x = x;
self.last_y = y;
self.aim_dir = 0;
self.aim_dist = 0;
self.aim_base_dist = 48;
self.autofire = false;
self.hold_mode = false;

// ANIMATION
self.channeling_anim_speed = 0.25
self.casting_anim_speed = 0.2;
self.climbing_anim_speed = 0.33;
self.lc_anim_speed = 0.07;
self.crouch_anim_speed = 0.12;
self.flip_anim_speed = 0.2;
self.backflip_anim_speed = 0.2;
self.running_anim_speed = 0.08;
self.walking_anim_speed = 0.088;
self.idle_anim_speed = 0.14;
self.idle_anim_start = 0;
self.victory_anim_end = 4;
self.damage_tint_ratio = 0.66;
self.status_tint_ratio = 0.33;
self.alpha = 0.96;
self.blink_rate = 6;
self.blink_off = false;

self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

// LIGHT
self.gives_light = true;
shape = shape_circle;
self.radius = 6;
self.ambient_light = 1;
self.direct_light = 0;

// CLIMB SEQUENCE
climb_sequence = ds_grid_create(5, 2);

// x
climb_sequence[# 0,0] = 0;
climb_sequence[# 1,0] = 0;
climb_sequence[# 2,0] = 6;
climb_sequence[# 3,0] = 6;
climb_sequence[# 4,0] = 12;

// y
climb_sequence[# 0,1] = 0;
climb_sequence[# 1,1] = -13;
climb_sequence[# 2,1] = -30;
climb_sequence[# 3,1] = -39;
climb_sequence[# 4,1] = -48;

// SLOTS
self.slot_maxnumber = 0;

// INVENTORY
self.inventory_size = 4;
self.inv_curr_index = -1;
self.inventory_ready = false;

self.inventory = ds_map_create();
self.inv_reserved = ds_map_create();

self.wanna_use = ds_map_create();
self.held_item = ds_map_create();
self.stop_holding = ds_map_create();

for(var i=1; i<= inventory_size; i++)
{
    inventory[?i] = noone;
    inv_reserved[?i] = noone;
    wanna_use[?i] = false;
    held_item[?i] = noone;
    stop_holding[?i] = false;
}

inv_reserved[? 2] = emp_grenade_obj;

last_added_item_step = 0;

//add_to_inventory(instance_create(x,y, emp_grenade_obj));

// QUBITS
self.qubits = 0;

// ATTACKER FORGET DELAY
self.att_forget_delay = 360;

// EFFECTS
self.burn_rate = 0.0015;
self.frozen_rate = 0.0025;
self.slow_rate = 0.002;
self.conf_rate = 0.0015;
self.weak_rate = 0.001;
self.bounce_rate = 0.001;
self.blind_rate = 0.003;

self.max_burn_time = 0.5;
self.max_frozen_time = 0.5;
self.max_slow_time = 0.5;
self.max_conf_time = 0.5;
self.max_weak_time = 0.5;
self.max_bounce_time = 0.8;
self.max_blind_time = 0.5;

self.max_frozen_total_time = 0.8;

self.sear_tick_damage = 0.0003;
self.was_frozen = true;
self.prefrost_image_speed = 0;

// CHANNELING
self.wanna_channel = false;
self.channeling = false;
self.channel_start_step = 0;
self.channel_orig_color = -1;
self.channel_duration = 0;
self.channel_duration_threshold = 480;
self.channel_maxboost = 0.003;
self.channel_coef = channel_maxboost/channel_duration_threshold;
self.channel_range = 196;
self.channel_force = 1;
self.channel_hp_cost = 5;
self.channel_effect = noone;
self.max_channeled_energy = 3;
self.safe_channeling = false;
self.total_orb_extra_energy = 0;

self.forced_channel = false;
self.interrupt_channel = false;
self.soundtime = 0;
self.my_channel_sound = noone;
self.channeling_full = false;
self.channeling_last_full_count = 0;

// HOVERING
self.hover_cycle_length = 60;
self.hover_speed = 2;
self.hover_altitude = 64;
self.hover_range = 8;
self.hover_yoffset = 24;

// INITIALIZATION
// STATE VARIABLES
self.step_count = 0;
// DIRECTIONS
self.hor_dir_held = false;
self.wanna_run = false;
look_toggled_on = false;
look_hold_start = -1;
look_hold_min_duration = 500;
look_on = false;
self.wanna_look = false;
self.facing_right = true;
facing=1;
self.looking_up = false;
self.looking_down = false;
self.look_start = -1;
self.recent_hor_dir = false;
self.recent_up = false;
self.recent_down = false;
self.desired_aim_dir = 0;
self.desired_aim_dist = 0;

// JUMPING AND FALLING
self.wanna_jump = false;
self.jumping_charge = 0;
self.is_jumping = false;
self.have_jumped = false;
self.have_dived = false;
self.is_doublejumping = false;
self.doublejump_start_step = 0;
//self.doublejump_facing = 1;
self.doublejump_count = 0;
self.holding_wall = false;
self.is_walljumping = false;
self.walljump_facing = 1;
self.have_walljumped = false;
self.walljump_begin_step = 0;
self.jumping_down = false;
self.last_jumped_down = noone;
//self.walljump_charge = self.walljump_max_charge;
self.climbing_up = false;
self.after_impact = false;

self.jumping_peaked = false;
self.airborne = false;
self.stuck = false;
self.skidding = false;
self.sliding = false;
self.wall_sliding = false;
self.unstuck_h = 0;
self.unstuck_v = 0;
last_standing_x = 0;
last_standing_y = 0;

// IDLE
self.idle_start = 0;
self.idle = false;

// ORBS
self.slots_absorbed = 0;
self.abi_slots_absorbed = 0;

// CASTING
self.wanna_cast = false;
self.auto_cast = false;
self.charging = false;
self.casting = false;
self.casting_hor = false;
self.casting_beam = false;
self.casting_ring = false;
self.casting_up = false;
self.casting_down = false;
self.casting_shield = false;
self.has_casted_ever = false;
self.shield_ready = true;
self.have_casted = false;
self.air_dashing = false;

// ALT FIRE
self.wanna_act = false;
self.was_acting = false;
self.has_acted = false;
self.action_cooldown = 0;
self.fire_cannon = false;

// ABILITIES
self.wanna_abi = false;
self.abi_triggered = false;
self.has_tped = false;

self.last_shield_color = -1;
self.last_shield_break_color = -1;
self.item_switch_dir = 0;

// LOST CONTROL
self.lost_control = false;
self.lost_control_step = 0;
self.front_hit = false;
self.back_hit = false;
self.hit_handled = false;
self.hit_ground = false;
self.falling_down = false;
self.at_rest = false;
self.recovered = false;
self.getting_up = false;
self.got_up = false;
self.protected = false;

// OTHER
self.locked = false;
self.seated = false;
self.hum = false;
self.guy_width = 0; 
self.guy_height = 0; 
self.last_mask = mask_index+1;
self.push_success = false;
self.warmed = 0;
self.score_multiplier = 1;
current_respawn_time = 0;

// GLITCHING
self.is_glitching = false;
self.glitch_phase = 0;
self.glitch_dir = 0;

// STATS
self.crystals = 0;
self.has_won = false;

// guy's footsteps, not game steps
last_step = 0;
last_step_sound = 2;
self.quiet_run = false;

// END INITIALIZATION
// STATE VARIABLES


// CONTROLS

self.keys = ds_map_create();
self.control_method = cpu_control_set;
self.control_set = no_control;       

self.control_obj = noone; 
self.control_index = -1;
self.controls_updated = false;

// COLORS

self.my_color = g_dark;
self.new_colors = ds_list_create();
self.my_last_color = my_color;
self.my_abi_color = -1;
self.my_abi_tint = c_dkgray;
self.tint_updated = false;
self.color_updated = true;

// ORBIT
self.color_slots = ds_list_create();
self.slot_number = 0;
self.current_slot = 0;
self.slot_angle_offset = 0;
self.slot_rot_speed = 1/240;
self.last_slot_number = self.slot_number;

self.slots_triggered = false;
self.alarm[3] = 2;
orb_dist = 32;
orb_base_size = 1.25;

// ORBS
orb_reserve = ds_map_create();
orb_reserve[? g_red] = 0;
orb_reserve[? g_green] = 0;
orb_reserve[? g_blue] = 0;

belt_size = ds_map_create();
for(col=g_dark; col<=g_blue; col++)
{
    if(col != g_yellow)
    {
        belt_size[? col] = 0;
    }
}

orb_belts = ds_map_create();
orbs_in_use = ds_map_create();
self.orbs_ready = false;

// ABILITY HINTS
self.potential_charge = ds_map_create();
self.potential_charge[? g_dark] = 0;
self.potential_charge[? g_red] = 0;
self.potential_charge[? g_green] = 0;
self.potential_charge[? g_blue] = 0;
self.potential_color = g_dark; //g_dark
self.potential_abi_name = "";

// CHARGING AND SPELLS
self.color_charge = ds_map_create();
self.color_charge[? g_dark] = 0;
self.color_charge[? g_red] = 0;
self.color_charge[? g_green] = 0;
self.color_charge[? g_blue] = 0;

self.charge_ball = noone;
self.my_shield = noone;
self.my_beam = noone;

// ABILITIES
//self.abi_cooldown = 0;
//self.abi_cooldown_length = 0;
//self.abi_script = empty_script;
//self.abi_script_delay = 0;
self.flashback_queue = ds_list_create();
self.state = ds_map_create();
self.old_state = ds_map_create();
self.has_haste = false;
self.bullettime = false;
self.flashing_back = false;
self.frozen_in_time = false;
self.berserk = false;
//self.size_pulse = 0;
self.ready_to_die = false;
teleport_uses_left = 0;
teleport_first_use_step = 0;
flashback_max_steps = 120;

// NEW ABIS
self.abilities = ds_map_create();
abilities[? g_dark] = abi_flashback;
abilities[? g_red] = abi_berserk;
abilities[? g_green] = abi_heal;
abilities[? g_blue] = abi_teleport;
abilities[? g_yellow] = abi_haste;
abilities[? g_magenta] = abi_ubershield;
abilities[? g_cyan] = abi_invisibility;
abilities[? g_white] = abi_base_teleport;

self.abi_last_used = ds_map_create();
self.abi_cooldown = ds_map_create();
self.abi_cooldown_length = ds_map_create();
self.abi_script = ds_map_create();
self.abi_script_delay = ds_map_create();
self.abi_last_script = ds_map_create();

for(var i = g_dark; i <= g_octarine; i++)
{
    abi_last_used[?i] = 0;
    abi_cooldown[?i] = 0;
    abi_cooldown_length[?i] = 0;
    abi_script[?i] = empty_script;
    abi_script_delay[?i] = 0;
    abi_last_script[?i] = 0;
}

self.cooldown_damage_coef = 5*singleton_obj.game_speed;
blocked_tp_cooldown = singleton_obj.game_speed;

self.has_tp_rush = false;
self.last_terrain = noone;

var color;
for(color = g_dark; color <= g_white; color++)
{
    self.abi_cooldown_length[? color] = DB.abi_cooldowns[? color];
}
/*
var player;
if(is_npc)
    player = -1;
else
    player = 0;    
my_player = ds_map_find_value(gamemode_obj.players, player);
*/
self.place_holder = noone;

// STATUS EFFECTS
init_status_effects();

// IMPACT SPEED PARTICLES
self.impact_speed_particles = instance_create_depth(x, y, 0, impact_speed_wave_obj);
impact_speed_particles.my_guy = id;