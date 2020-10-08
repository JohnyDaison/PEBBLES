event_inherited();

orig_friction = 0.1;
gravity_coef = 0.25;
gravity = gravity_coef;
sprite_index = charge_ball2_spr;
radius = 24;
core_radius = 16;
particle_count = 15;
/*
if(y > 0)
{
    my_sound_play(artillery_shot_sound, true);
}
*/
orig_ambient_light = 0.8;
self.name = "Artillery Shot";

observer_range = 1;
observer_add(chunkgrid_obj, id);
