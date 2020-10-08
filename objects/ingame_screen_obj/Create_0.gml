event_inherited();

my_color = g_white;
// states: recharging, ready, active
ready = true;
active = false;
immovable = true;
walkable = false;
width = 256;
height = 144;
border_width = 8;

if(image_xscale != 1 || image_yscale != 1)
{
    width = abs(bbox_left - bbox_right);
    height = abs(bbox_bottom - bbox_top);
}

camera = ingame_camera_obj.id;

max_speed = 0;

name = "Screen";

