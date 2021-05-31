event_inherited();

enabled = true;
activated = false;

my_color = g_white;
terrain_holder = true;
radius = 32;

my_guy = noone;
difficulty_level = 1;
max_difficulty_level = 15;
guy_was_dead = false;

with(level_end_obj)
{
    for_player = 0;
}

alarm[2] = 90;
