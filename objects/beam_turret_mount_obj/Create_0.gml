event_inherited();

aim_dir = 0;
aim_dist = 32;
ball_overcharge = 0;
ball_chargerate = 0.1;
slots_absorbed = 5;

walkable = true;

turret = instance_create(x,y,charge_ball_obj);
turret.my_guy = id;
turret.my_mount = id;
turret.my_color = g_white;
turret.tint_updated = false;
charge_ball = turret;

my_color = g_white;
tint = c_white;
tint_updated = true;
sprite_index = beam_turret_spr;

name = "Beam Turret"; 

alarm[1] = 2;

