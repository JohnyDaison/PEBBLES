event_inherited();

name = "Overcharge";
color = g_red;
icon = overcharge_spr;
particle_system = berserk_flame_obj;
buff = 1; //{-1;0;1}
start_script = status_overcharge_start;
end_script = status_overcharge_end;
max_charge = 1000;
/*
max_duration = 0;
signal_ratio = 1000;
damage_ratio = 1000;
*/
