event_inherited();

turret = instance_create(x+15,y+15,turret_body_obj);
turret.my_mount = id;
turret.my_struct = id;
my_color = g_white;
tint = c_white;
tint_updated = true;
sprite_index = turret_mount2_spr;
shot_radius = 14;

alarm[1] = 2;
