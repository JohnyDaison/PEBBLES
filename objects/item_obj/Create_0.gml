event_inherited();

loop_height = 10;
dir = 1;
step = 0;
hover_offset = 2;
hover_rate = 10;
gravity_coef = 0.06;
friction_coef = 0.02;
alarm[0] = hover_rate;
center_gravity = 0.1;
collectable = true;
collected = false;
reserved = false;
inv_index = -1;
placed = false;
sticky = false;
stuck_to = noone;
stuck_x = 0;
stuck_y = 0;
attached = false;
airborne = true;
armed = false;
armed_blink_phase = 0;
armed_blink_ratio = 0.9;
armed_blink_step = 0.2;
armed_blink_dir = 1;
last_attacker_init();

despawning = false;
//alarm[1] = 0;
despawn_time = 5400;
fade_counter = 1;
fade_rate = 0.01;

newly_got_steps = 0;
newly_got_anim_cycle = 20;
newly_got_anim_sizecoef = 3;
newly_got_anim_duration = 40;
newly_got_anim_peak = 20;

is_duplicate = false;
duplicate_me = false;
not_for_guide = false;
for_player = -1;
alarm[2] = 3;

// LIGHT (experimental)
gives_light = true;
shape = shape_circle;
ambient_light = 0.2;
direct_light = 0.05;

// HOLO
self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

my_guy = id;
last_my_guy = id;
my_shield = noone;
max_speed = 16;
if(object_index != color_orb_obj)
{
    depth = 0;
}
usable = true;
used = false;
destroy_on_use = false;
stack_size = 1;
stack_font = label_font;
max_stack_size = 1;
activatable = false;
consumable = false;
holdable = false;
cursed = false;
hold_mode = false;
active = false;
unique = false;
multicolor = false;
push_success = false;
inventory_spr = item_placeholder_spr;
custom_sprite = false;
draw_label = (gamemode_obj.item_labels != "off");
if(gamemode_obj.item_labels == "large")
{
    label_distance = 32;
    label_scale = 1.5;
}
base_label_distance = label_distance;
radius = 23;
touching_ground = false;
top_touching_ground = false;
touching_entity = noone;
pickup_show_name = true;
level_upgrade = false;
level_upto = false;
level_setter = false;
levels = ds_map_create();
consumed_on_pickup = false;
use_cooldown_length = 0;
use_cooldown_left = 0;
keep_on_death = false;
description_name = "";
description = "";
flavor_text = "";

fresh = true;

show_debug_message("ITEM " + object_get_name(object_index) + " created at [" + string(x) + "," + string(y) + "]");