event_inherited();

image_speed = 0;
slots_absorbed = 0;
immovable = true;
airborne = true;
max_speed = 20;
walkable = true;
hp = 5;
my_color = g_white;
my_shield = noone;
shield_ready = true;
destroyed = false;
name = "Plasma Cannon";
draw_label = true;
my_camera = noone;
my_guy = noone;
charge_ball = noone;
ammo_popup = noone;
ammo_x = 0;
ammo_y = -64;

barrel_anim_speed = 0.1;
barrel_anim_index = 0;
barrel_anim_length = 4;

shield_overcharge = 1;
base_shield_chargerate = 0;
shield_chargerate = base_shield_chargerate;
shield_threshold = 6;
protected = false;
shield_repair_time = 1200;
shield_color = g_white;

base_angle = 90;
angle_range = 235;
aim_dir = base_angle;
hp_y_offset = 8;
guy_y_offset = 16;
gui_x = 0;
gui_y = 0;
hpbar_x1 = 0;
hpbar_y1 = 0;
hpbar_x2 = 0;
hpbar_y2 = 0;
hpbar_x1 = -17;
hpbar_y1 = 3;
hpbar_x2 = 17;
hpbar_y2 = 13;
hpbar_width = 34;
hpbar_xx = 0;
hpbar_tint = DB.colormap[? g_green];

shot_color = g_black;

// ORBS
orbs = ds_map_create();
orbs[? g_red] = 0;
orbs[? g_green] = 0;
orbs[? g_blue] = 0;

// ORB FADING
orb_light = ds_map_create();
orb_light[? g_red] = 0;
orb_light[? g_green] = 0;
orb_light[? g_blue] = 0;

hp_font = text_popup_font;
aim_speed = 0.2;
aim_dist = 80;
barrel_dist = 78;
arrow_dist = 48;
charging = false;
autofire = false;
ball_overcharge = 2.5;
ball_chargerate = 0.5;

// PLATFORMS
/*
i = instance_create(x-32,y+48,platform_obj);
i.my_struct = id;
i = instance_create(x+32,y+48,platform_obj);
i.my_struct = id;
*/

// LIGHT
radius = 24;
gives_light = true;
shape = shape_circle;
ambient_light = 0.5;
direct_light = 0.1;

my_waypoint = noone;

if(instance_exists(place_controller_obj))
{
     var wp = instance_create(x, y + guy_y_offset, npc_waypoint_obj);
     wp.auto_adjust = false;
     wp.cannon_point = true;
     my_waypoint = wp;
     
     if(!place_controller_obj.auto_init_waypoints)
     {
        wp.waypoint_id = "wp" + string(wp.id);
     }
     
     regenerate_nav_graph();
}