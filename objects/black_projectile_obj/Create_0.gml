event_inherited();

my_sound_play(shot1_sound);
//my_sound_play_colored(shot1_sound, g_black);

if(instance_number(object_index)==1)
{
    my_sound_loop(black_projectile_sound);
    //my_sound_play_colored(black_projectile_sound, g_black, false, true);
}
force_used = 0;
stolen_slots = ds_list_create();
slot_count = 0;
picked_pickups = ds_list_create();
pickup_count = 0;
radius = 80;
orig_friction = 0.05;
gravity_ratio = 0;
orb_dist = 2;

return_distance_limit = 8;
return_max_axisdelta = 6;

start_trail_delay = 20;
min_trail_delay = 8;
trail_delay = start_trail_delay;
alarm[2] = trail_delay;

//sprite_index = noone;
self.tint_updated = true;
self.tint = merge_color(c_purple,c_white,0.333);
highlight_alpha = 0.666;

self.name = "Vortex";

