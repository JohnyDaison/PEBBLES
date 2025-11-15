event_inherited();

self.follow_target = noone;
self.attack_target = noone;
self.ammo_drop_count = 0;
self.crystal_drop_count = 0;
self.my_score_value = 0;
self.incoming_lockon_range = 160;
self.smoke_resistant = false;
self.drop_item = noone;
self.att_forget_delay = 300;

init_equipment_sys();

self.my_guy = self.id;
self.my_shield = noone;
self.my_color = g_octarine;
self.multicolor = true;
self.tint = c_white;
self.damage_tint_ratio = 0.66;
self.done_for = false;
self.custom_sprite = false;

self.push_success = false;
self.walkable = false;

gamemode_obj.stats[? "mobs_spawned"] += 1;
