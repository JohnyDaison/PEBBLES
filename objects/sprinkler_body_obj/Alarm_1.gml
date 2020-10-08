/// @description  GIVE EQUIPMENT
add_hardpoint(0,   0, hp_shield);
add_hardpoint(0,   0, hp_shield);
//add_hardpoint(weapon_distance,  0, hp_weapon);
add_hardpoint(0, 0, hp_weapon); //-weapon_distance
//add_hardpoint(-weapon_distance, 0, hp_weapon);
add_hardpoint(0, 0, hp_weapon);  //weapon_distance
add_hardpoint(0, 0, hp_weapon);
add_hardpoint(0, 0, hp_weapon);

my_shield1 = instance_create(x,y,sprinkler_shield_obj);

body_equip(id, my_shield1);

my_shield2 = instance_create(x,y,sprinkler_shield_obj);

body_equip(id, my_shield2);

var gun, gun_angle = 0;
var gun_angle_step = -360/gun_count;

repeat(gun_count)
{
    gun = instance_create(x,y, sprinkler_gun_obj);
    
    body_equip(id, gun);
    gun.refire_time = refire_time * gun_count;
    
    gun.rel_rotation_angle = gun_angle;
    gun_angle += gun_angle_step;
    gun.rel_rotation_speed = 10/gun_count;
}

