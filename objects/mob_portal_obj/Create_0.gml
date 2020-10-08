event_inherited();

// TODO: this should be map to allow for many mobs and different settings for each
spawn_sprinkler = true;
spawn_spitters = true;

first_spawn = gamemode_obj.mob_spawners_first_delay * singleton_obj.game_speed;
respawn_time = gamemode_obj.mob_spawners_respawn_delay * singleton_obj.game_speed;
particles_time = 10 * singleton_obj.game_speed; // includes siren_time
siren_time = 6 * singleton_obj.game_speed; // siren_time is the end of particles_time

my_siren_sound = noone;

alarm[0] = 1;

image_speed = 0;
emit_particles = false;
enabled = true;
active = false;
name = "Port IN";
draw_label = false;
invisible = true;

