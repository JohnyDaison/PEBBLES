/// @description INIT AND PARAMS
event_inherited();

name = "Base Crystal";
self.hp = 10;
self.immovable = true;
self.terrain_holder = true;
has_cannon = true;

// SPAWNING
first_spawn_time = 240;
respawn_time = 420;
protection_time = 120;

alarm[1] = 1;

// SHIELD
shield_threshold = 12;
shield_power = 6;

var mod_sp = mod_get_state("base_crystal_shield_power");
if (!is_undefined(mod_sp) && !is_bool(mod_sp) ) {
    shield_power = mod_sp;
}

shield_repair_time = max(1, shield_power) * 300;

var mod_hp = mod_get_state("base_crystal_hp");
if (!is_undefined(mod_hp) && mod_hp != false) {
    damage = hp - mod_hp;
}

holographic = mod_get_state("holographic_spawners");

if(gamemode_obj.inited_player_count == gamemode_obj.player_count)
{
    gamemode_obj.inited_player_count = 0;
}

// INIT
self.my_guy = noone;
self.my_field = noone;
self.place_holder = noone;
base_cannon = noone;
my_shield = noone;
flag_icon = noone;
my_players = ds_list_create();

self.enabled = false;
self.activated = false;
self.destroyed = false;
shield_ready = false;
done_for = false;
protected = false;

// SPAWNING
for_player = -1;
player_start_point = true;
players_created = false;
spawn_points = ds_map_create();

// SHIELD
shield_overcharge = 1;
base_shield_chargerate = 0;
shield_chargerate = base_shield_chargerate;

// COLOR
my_color = g_white;
next_color = ds_map_find_value(DB.colormap,my_color);
color_cycle_length = 30;

alarm[2] = 1;

// CRYSTALS
crystals = ds_list_create();

crystal_angle_offset = 0;
crystal_rot_speed = 1/240; // 1 orbit in 240 ticks

crystal_number = 0;
max_crystals = 5;
crystal_boost = 0.2;
crystal_heal = 1;
crystal_guy_regen = 0.00075;

alarm[5] = 2;

// HOLO
self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.3;
self.holo_maxalpha = 0.5;

// LIGHT
radius = 24;
gives_light = true;
shape = shape_circle;
ambient_light = 0.6;
direct_light = 0.1;
