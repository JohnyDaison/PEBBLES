my_guy = noone;
my_spawner = noone;
my_override = noone;
reticles = false;
draw_status = false;
border_color = c_white; // c_black
border_width = 8;
look_zoom_delay = 2;
look_zoom_duration = 0.5;
observer_range = 3;

// view and panel
view_x = 0;
view_y = 0;
view_surface = noone;
width = 0;
height = 0;

// darkness
darkness_surface = noone;
darkness_alpha = 0;
surface_width = 0;
surface_height = 0;
bg_light = noone;
main_light = noone;
light_x_offset = 0;
light_y_offset = 0;
light_size_coef = 1;
darkness_light_size_coef = 3;

var darkness_value = mod_get_state("darkness");
if (is_number(darkness_value)) {
    darkness_alpha = darkness_value / 100;
}

death_cover_show = false;

// background and camera movement coefs
bg_shift_ratio[0] = 1;
bg_shift_ratio[1] = 0.1;
bg_speed_ratio[0] = 1;
bg_speed_ratio[1] = 0;
move_speed_coef = 0.07; //0.06 //0.05 //0.1 //0.15
bg_zoom_ratio[0] = 0;
bg_zoom_ratio[1] = 1;


// init state
follow_guy = false;
follow_spawner = false;
follow_shot = false;
follow_override = false;
player = 0;
view = -1;
guy_hor_dist = 0;
guy_ver_dist = 0;
box_xoffset = 0;
box_yoffset = 0;
box_xsize = 32;
box_ysize = 64;
followed_x = x;
followed_y = y;
move_speed_x = 0;
move_speed_y = 0;
on = false;
only_cam = false;
camera_ready = false;

// looks
draw_frame = true;
potential_color = c_orange;
body_color = c_orange;
//shield_col = c_orange;

inner_color = c_orange;
outer_color = c_orange;

// read terrain
self.read_terrain = true;
self.ter_list = undefined;
self.ter_list_length = -1;
self.ter_grid_x = -10;
self.ter_grid_y = -10;

self.my_chunkgrid = noone;

// viewshake
shake_dir = 0;
shake_dist = 0;
shake_source_dir = 0;
last_shake_dist = 0;
shake_dist_decay = 0.25;

// zoom
zoom_level = 1;
min_zoom = 0.66;
base_normal_zoom = 1;
small_normal_zoom = 0.8;
normal_zoom = base_normal_zoom;
look_zoom = 0.8;
zoom_speed = 0.0025;
stop_zoom = false;

alarm[0] = 2;


// hack, variable did not exist at camera_obj EndStep (line 17)
//     if(cur_grid_x != obs_chunk_x || cur_grid_y != obs_chunk_y)
obs_chunk_x = -1;
obs_chunk_y = -1;
