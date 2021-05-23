event_inherited();

self.fired = false;
self.total_energy = 42; //420;
self.energy = total_energy;
self.quantum_size = 1;
self.delay = 420;
self.start_step = -1;
self.life = 600;
self.small_bolt_ratio = 0.33;

my_sound_play(starfall_sound);

my_color = irandom_range(g_red,g_cyan);
multicolor = true;
tint_updated = false;

// LIGHT
gives_light = true;
ambient_light = 0.8;
direct_light = 0.6;
radius = total_energy/4; //4.2
shape = shape_circle;

//PARTICLES
part_system = part_system_create();
part_system_depth(part_system, 20);
part_type = part_type_create();
part_type_sprite(part_type,part_pixel_spr,false,false,false);
part_type_colour1(part_type,c_white);
part_type_blend(part_type,false);
part_type_scale(part_type, 1, 1);
part_type_size(part_type, 1, 1, 0, 0);
part_type_life(part_type,10,10);
part_type_gravity(part_type,0,0);
part_type_orientation(part_type,0,0,0,0,0);

name = "Star Core";
draw_label = true;
