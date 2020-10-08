event_inherited();

radius = 16;
impact_force = 2; // energy/damage
image_alpha = 0;
image_xscale = 2;
my_guy = id;

lightning_base_step_size = 32;
lightning_base_thickness = 3;
lightning_base_width = 16;
/*
lightning_step_size = lightning_base_step_size;
lightning_thickness = lightning_base_thickness;
lightning_width = lightning_base_width;
*/
lightning_steps = 1;

my_color = irandom_range(g_red, g_octarine);

anim_step = 0;
anim_fadein_steps = 4;
anim_damage_steps = 2;
anim_fadeout_steps = 42;
anim_total_length = anim_fadein_steps + anim_damage_steps + anim_fadeout_steps;

terrainfall_threshold = 0.75;
trigger_terrainfall = false;

self.name = "Lightning strike";

my_impact = instance_create_depth(x,y, depth-1, lightning_strike_impact_obj);
my_impact.my_strike = id;

// LIGHT
self.gives_light = true;
shape = shape_circle;
orig_ambient_light = 1.5;
orig_direct_light = 1.5;
ambient_light = orig_ambient_light;
direct_light = orig_direct_light;
