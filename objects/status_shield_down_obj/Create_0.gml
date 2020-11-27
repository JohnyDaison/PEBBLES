event_inherited();

name = "Shield down";
codename = "shield_down";
color = g_octarine;
icon = status_shield_down_icon_new_spr;
particle_system = shield_down_sparks_obj;
buff = -1; //{-1;0;1}
step_script = status_shield_down_step;
max_charge = 180;
/*
max_duration = 0;
signal_ratio = 1000;
damage_ratio = 1000;
*/
