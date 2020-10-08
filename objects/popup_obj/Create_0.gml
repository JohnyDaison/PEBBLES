depth = -1000;
source = noone;

bg_color = c_white;
self.my_color = g_black;
self.tint_updated = false;
self.tint = c_dkgray;

fading = true;
fading_in = true;
fading_out = false;
fade_in_length = 15;
max_alpha_length = 30;
fade_out_length = 90;
fade_ratio = 0.2;
rise_speed = 1;
min_alpha = 0.2;
max_alpha = 1;

life_length = fade_in_length + max_alpha_length + fade_out_length;
alarm[0] = life_length;
life_left = alarm[0];

cam_xcoord_map = ds_map_create();
cam_ycoord_map = ds_map_create();

with(camera_obj) 
{
    other.cam_xcoord_map[? self.view] = other.x-x;
    other.cam_ycoord_map[? self.view] = other.y-y;
}



