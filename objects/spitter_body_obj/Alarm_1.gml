/// @description GIVE EQUIPMENT
add_hardpoint(0, 0, hp_shield);

add_hardpoint(-weapon_distance, 0, hp_weapon);

gun = instance_create_depth(x,y, depth-1, spitter_gun_obj);
gun.rel_rotation_angle = 180;

body_equip(id, gun);

