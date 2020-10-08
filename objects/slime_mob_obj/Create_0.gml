event_inherited();

my_color = g_black;

hp = 0.25;
base_energy = 0.7;
max_energy = 2;
energy = base_energy;
facing = 1; //-1;1
radius = 14;
max_speed = 6;
splat_speed = 8;
walkable = true; // if same color
my_score_value = 2;
crawl_speed = 1.69;
rest_time = 42;
prep_time = 42;
inside_wall_damage = 0.005;
slime_ball_count = 7;
incoming_lockon_range = 192;
supported_terrain = solid_terrain_obj;

coltype_var = solid_terrain_obj;
//coltype_var = coltype_blocking;

blocking_terrain = noone;
head_terrain = noone;
next_terrain = noone;

jump_hboost = 4;
jump_vboost = 3;

gravity_coef = 0.35;
friction_air = 0.05;
friction_ground = 0.1;
image_speed = 0;

touch_damage = 0.01;
touch_damage_threshold = 0.25;

resting = false;
rested = false;
prepping = false;
prepped = false;
turning = false;
crawling = true;
jumping = false;
falling = false;
airborne = true;

rest_sprite = 0;
prep_sprite = 1;
crawl_sprite = 2;
takeoff_sprite = 3;
jump_sprite = 4;
fall_sprite = 4;

// LIGHT

self.gives_light = true;
shape = shape_circle;
self.ambient_light_coef = 0.4;
self.direct_light_coef = 0.15;
self.ambient_light = self.ambient_light_coef;
self.direct_light = self.direct_light_coef;
self.light_yoffset = -1.5;

name = "Slime";

