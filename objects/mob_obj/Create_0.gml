event_inherited();

active = false;
following = false;
evading = false;
moving = false;
follow_target = noone;
attack_target = noone;
evade_target = noone;
move_target_x = x;
move_target_y = y;
ammo_drop_count = 0;
crystal_drop_count = 0;
my_score_value = 0;
//custom_tint = false;
incoming_lockon_range = 160;
smoke_resistant = false;
drop_item = noone;

/*
hardpoint_count = 0;
hardpoint_x = ds_map_create();
hardpoint_y = ds_map_create();
hardpoint_type = ds_map_create();
equipment_list = ds_list_create();
*/
init_equipment_sys();

my_guy = id;
my_shield = noone;
self.my_color = g_octarine;
multicolor = true;
tint = c_white;
damage_tint_ratio = 0.66;
done_for = false;
custom_sprite = false;

push_success = false;
walkable = false;

gamemode_obj.stats[? "mobs_spawned"] += 1;
