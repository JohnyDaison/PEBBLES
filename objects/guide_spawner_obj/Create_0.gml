event_inherited();

enabled = true;
activated = false;

my_color = g_white;
terrain_holder = true;
radius = 32;

my_guy = noone;
introduction_finished = false;

spawn_points = ds_map_create();

alarm[2] = 90;

if(!rule_get_state("tut_guide"))
{
    introduction_finished = true;
    alarm[2] = -1;
}
