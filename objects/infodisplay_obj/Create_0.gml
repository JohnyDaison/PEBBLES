event_inherited();

name = "Info Display";
my_color = g_white;

border_color = c_dkgray;
bg_color = c_black;
bg_anim_color = c_white;
bg_anim_phase = 0;
bg_anim_speed = 0.02;
bg_anim_length = 4;
bg_anim_alpha = 0.1;
bg_col1_phase = 1;
bg_col2_phase = 2;

shrink_anim_phase = 0;
shrink_anim_speed = 0.05;

init_animation();

shape = shape_rect;
base_size = 32;
radius = 64;
corner_radius = 6;
progress_bar_margin = 3;
progress_bar_height = 5;
progress_bar_alpha = 0.8;
progress_bar_color = c_white;

diagonal = point_distance(0,0, base_size*image_xscale, base_size*image_yscale);
radius = max(radius, diagonal/2 + 64);
image_speed = 0;
if(shape == shape_circle)
{
    direct_light = 0;
    ambient_light = 0.05;
}
if(shape == shape_rect)
{
    direct_light = 0;
    ambient_light = 0.5; // 0.5
}
ambient_light_full = ambient_light;

max_speed = 40;

width = 0;
height = 0;
ready = false;
active = false;
immovable = true;
walkable = false;

