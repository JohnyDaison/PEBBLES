event_inherited();

energy = 0;
spawn_cost = 1;
drain_speed = 0.002;
black_tint = DB.colormap[? g_dark];
immovable = true;
radius = 32;
spawn_height = 32;

max_arm_angle = 90;
des_arm_angle = max_arm_angle;
arm_angle = max_arm_angle;
arm_offset_x = 13;
arm_offset_y = -2;
arm_tip_offset_x = 16;
arm_tip_offset_y = -10;

lightning_steps = 5;
lightning_thickness = 5;
lightning_width = 16;

slots_enabled = false;
spawned_item_count = 0;
spawnables = ds_map_create();

ds_map_add(spawnables,health_obj,15); //15
ds_map_add(spawnables,orb_battery_obj,5); //10
ds_map_add(spawnables,tp_rush_obj,2); //15
ds_map_add(spawnables,crystal_obj,5); //15
//ds_map_add(spawnables,pickup_magnet_obj, 2);
ds_map_add(spawnables,emp_grenade_obj, 15); //5
ds_map_add(spawnables,spraycan_item_obj, 5); //5

spawning = false;
standby = false;
spawned_item = noone;
spawn_effect = noone;
duplicate_items = false;
