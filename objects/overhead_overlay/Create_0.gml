event_inherited();

my_guy = noone;

width = 185;
dial_dist = 40;
name_dist = 88;
icon_dist = 24;
fade_speed = 0.004;
hide_speed = 0.008;
bar_speed = 0.0005;
rgb_color_order = false;
do_fading = true;
reset_fade = false;
bg_sprite = dial_big_bg_spr;
rotating_arrow_image = 0;
rotating_arrow_speed = 0.5;
rotating_arrow_image_count = 42;
rotating_arrow_alpha = 0.8;
rotating_arrow_alpha_decay = 0.001;
rotating_arrow_alpha_min = 0;

abi_font = label_font;
abi_status = 0;
abi_tint =  c_black;
abi_color = g_red;
last_abi_status = abi_status;
last_abi_name = "";
abi_name_maxfade = 2;
abi_name_fade = abi_name_maxfade;
abi_name_minfade = 0.2;
abi_panel_icon_bg_radius = 18;
hide_abi = false;
hide_storage = false;

att_draw_dist = 64;

name_offset = 0;
base_name_alpha = 0.5;
speaking_name_alpha = 0.1;
name_alpha = base_name_alpha;
guy_y = 0;
abi_name = "";
abi_icon = player_spr;
label_height = 0;
label_width = 0;

// STATUS EFFECTS PANEL
status_panel_height = 48;
status_bar_width = 33;
status_bar_space = 16;
card_half = round((status_bar_space/2 + status_bar_width)/2);
card_alpha = 0.7;
card_show_min_status_left = 30;
card_hide_inactive_delay = 30;
status_order = ds_map_create();
status_card_visible = ds_map_create();
status_last_active = ds_map_create();

i=1;

//status_order[? i++] = g_dark;
status_order[? i++] = g_blue;
status_order[? i++] = g_green;
status_order[? i++] = g_red;
status_order[? i++] = g_cyan;
status_order[? i++] = g_magenta;
status_order[? i++] = g_yellow;
status_order[? i++] = g_white;
status_order[? i++] = g_octarine;

var effect_id;

for(var i=0; i<DB.status_effect_count; i++)
{
    effect_id = DB.status_effects_list[| i];
    
    status_card_visible[? effect_id] = false;
    status_last_active[? effect_id] = 0;
}


// ABI PANEL
abi_panel_height = 61;
abi_bar_width = 41;
//abi_bar_space = 16;
abi_group_space = 6;
abi_bar_space = 10;
abi_outline_size = 3;
abi_bg_color = c_white;
abi_outline_color = merge_color(c_gray, c_white, 0.5);

group_count = 4;
abi_groups = ds_map_create();

var group, group_members, i, ii=1;

for(i=1; i<=group_count; i++)
{
    abi_groups[?i] = ds_map_create();
}

i=1;
ii=1;
group = abi_groups[? i++];
group[? ii++] = g_dark;

ii=1;
group = abi_groups[? i++];
group[? ii++] = g_blue;
group[? ii++] = g_green;
group[? ii++] = g_red;

ii=1;
group = abi_groups[? i++];
group[? ii++] = g_cyan;
group[? ii++] = g_magenta;
group[? ii++] = g_yellow

ii=1;
group = abi_groups[? i++];
group[? ii++] = g_white;

abi_panel_width = 0;

for(i=1; i<=group_count; i++)
{
    group = abi_groups[? i];
    group_members = ds_map_size(group);
    abi_panel_width += group_members * (abi_bar_width + abi_bar_space);
}

abi_panel_width += group_count * abi_group_space;

// ORB BELTS
belt_size = 0;
orb_belt_width = 46;
orb_border_width = 2;
orb_panel_width = 0;
orb_panel_height = belt_size*orb_belt_width;
show_chargeball_orbit = true;
show_belts = true;
show_abilities = true;
show_belt = ds_map_create();
belt_list = ds_map_create();
left_side_belt_order = ds_list_create();
right_side_belt_order = ds_list_create();

for(col=g_dark; col<=g_blue; col++)
{
    if(col != g_yellow)
    {
        show_belt[? col] = false;
        belt_list[? col] = ds_list_create();
    }   
}

i=0;
left_side_belt_order[|i++] = g_blue;
left_side_belt_order[|i++] = g_green;
left_side_belt_order[|i++] = g_red;
left_side_belt_order[|i++] = g_dark;

i=0;
right_side_belt_order[|i++] = g_dark;
right_side_belt_order[|i++] = g_blue;
right_side_belt_order[|i++] = g_green;
right_side_belt_order[|i++] = g_red;

chborbit_blink_time = 0;
belts_blink_time = 0;
abilities_blink_time = 0;
belts_blink_count = 16;

chborbit_blink_rate = 10;
belt_blink_rate = 10;
abilities_blink_rate = 10;

// STORAGE 
slot_size = 24;
slot_offset = -slot_size * 1.5;

// ORB COUNTS
last_orbs = ds_map_create();
last_orbs[? g_red] = 0;
last_orbs[? g_green] = 0;
last_orbs[? g_blue] = 0;

// ORB FADING
orb_light = ds_map_create();
orb_light[? g_red] = 0;
orb_light[? g_green] = 0;
orb_light[? g_blue] = 0;
