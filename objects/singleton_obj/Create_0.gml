// OVERLAYS
self.show_fps = false;
self.show_keyboard_state = false;
self.show_joystick_state = false;
self.show_colorimatrix = false;
self.show_terrain = false;
self.show_chunkgrid = false;
self.show_minimap = false;
self.show_console = "hide";
self.show_console_mode = "peek";

self.game_speed = 60;
self.master_volume = 50;


// INPUTS

instance_create(0,0, keyboard1_obj);
instance_create(0,0, keyboard2_obj);
instance_create(0,0, joystick1_obj);
instance_create(0,0, joystick2_obj);

for(i=0;i<4;i++)
{
    var inst = instance_create(0,0, gamepad_input_obj);
    inst.index = i;
    inst.number = i+1;
}


// TERRAIN GRID
grid_cell_size = 96; //96
grid_margin = 0;
grid_width = 0;
grid_height = 0;
terrain_grid = noone;
draw_ter_lists = false;
draw_depths = false;

// TERRAIN CHECK
terrain_checked = false;

step_count = 0;

/*
joystick1_on = false;
joystick2_on = false;
alarm[1] = 1;
*/
last_gui_device = -1;


// GFX
player_panel_height = 112;

fullscreen = false;
fullscreen_set = false;
aa_level = 0;
aa_level_set = 0;
vsync = true;
vsync_set = false;
display_updated = false;
do_my_visible_optim = true;
scale_up_gui = true;
interpolate = true;
interpolate_set = false;

windowed_width = 1280;
windowed_height = 720;

fullscreen_width = 1920;
fullscreen_height = 1080;

current_width = windowed_width;
current_height = windowed_height;

player_view_width = current_width/2;
player_view_height = current_height;

player_port_width = current_width/2;
player_port_height = current_height;

draw_object_labels = false;
draw_bboxes = false;

draw_lights = true;
current_font = label_font;
font_vmargin_coef = 4;

new_background_color = __background_get_colour( );
self.bgcolor_updated = true;

// AUDIO BALANCING
balance_range = 0.9;
balance_step = 0.05;
shots_buffer = 0;
wallhit_buffer = 0;
wallhum_buffer = 0;
shieldhit_buffer = 0;
shot_volume = 1;
wallhit_volume = 1;
wallhum_volume = 1;
shieldhit_volume = 1;

octarine_tint = c_black;
force_feedback = true;

// PAUSE
paused_room = noone;
paused = false;
paused_surface = noone;
pause_surface_str = "";
has_unpaused = false;
were_persistent = ds_list_create();

// OPTIMIZATION

// INIT FRAME SYSTEM
init_frames();
// CREATE CURSOR
instance_create(mouse_x,mouse_y,cursor_obj);
// CREATE LIGHT SYSTEM
/*
instance_create(0,0,background_light_obj);
instance_create(0,0,main_light_obj);
*/
// GO TO MAIN MENU AFTER A DELAY
singleton_obj.alarm[0] = 5;