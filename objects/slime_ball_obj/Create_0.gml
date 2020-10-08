event_inherited();

orig_friction = 0.02;
gravity_coef = 2*orig_friction;
gravity = gravity_coef;
wall_bounce_damping = 0.5;
radius = 2;
was_stopped = true;
my_sound_play(choose(step1_sound, step2_sound));

make_particles = false;
orig_ambient_light = 0.8;

self.name = "Slime ball";

