event_inherited();

name = "Burn";
codename = "burn";
color = g_red;
icon = status_burn_icon;
particle_system = burn_flame_obj;
buff = -1; //{-1;0;1}
step_script = status_burn_step;
max_charge = 300;
max_duration = 0;
signal_ratio = 666;
damage_ratio = 666;

tick_damage = 0.0015;

