event_inherited();
my_guy = noone;
my_camera = noone;

inv_size = -1;
last_pickup = ds_map_create();
last_stacksize = ds_map_create();
slot_size = 47;
slot_dist = 16;
slot_range = slot_size + 12;
name_height = 32;
width = 0;
height = 0;
stack_xx = slot_size* 0.4;
stack_yy = slot_size* 0.4;
stack_font = text_popup_font;
stack_radius = 12;

bg_alpha = 1;
bg_tint = ds_map_create();
blink_tint = ds_map_create();
blink_start = ds_map_create();
//bg_radius = floor(slot_size/2) + 16;
blink_tick = 30; 
blink_length = 180;
red_tint = c_red;
get_tint = c_green;
bg_sprite = inventory_bg_spr;
border_sprite = inventory_cursor_spr;
full_inv_blink = false;

draw_inventory = true;
whole_inv_blink_time = 0;
whole_inv_blink_rate = 10;
