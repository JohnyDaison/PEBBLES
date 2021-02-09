event_inherited();

my_range = 416;
radius = 24;
aim_dir = 0;
aim_dist = 15;
shot_radius = 7;
ball_overcharge = 0;
ball_chargerate = 0.25;
slots_absorbed = 2;
immovable = true;

turret = instance_create(x,y,charge_ball_obj);
turret.my_guy = id;
turret.my_mount = id;
turret.my_color = g_white;
turret.tint_updated = false;
charge_ball = turret;

ball_overcharge = -charge_ball.max_charge + 3*charge_ball.small_charge;

my_color = g_white;
tint = c_white;
tint_updated = true;
sprite_index = turret_mount4_spr;

name = "Small Turret"; 

alarm[1] = 2;

