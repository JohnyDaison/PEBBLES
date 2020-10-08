event_inherited();

do_glow = false;
custom_sprite = false;
sprite_index = new_wall2_spr;
mask_index = new_wall2_spr;
image_speed = 0;
image_index = 0;
shape = shape_rect;
width = 32;
height = 32;
energy = 0;
falling = false;
falling_force = 0;
impact_threshold = 10;
impact_ratio = 1/42;
max_impact_force = 1;
shake_range = 360;
moving = false;
unstable = false; //false
done_for = false;
destroyed = false;
has_pusher = false;
my_shield = noone;
my_guy = noone;

error_placement = false;

core = core_none;
core_updated = false;
cover = cover_none;
cover_spr = noone;
cover_color = -1;
cover_tint = c_gray;
cover_updated = false;

// TODO: Maybe move this to DB ... ?
// ˇ
active_threshold = DB.terrain_config[? "active_threshold"];
behaviour_threshold = DB.terrain_config[? "behaviour_threshold"];
status_threshold = DB.terrain_config[? "status_threshold"];
damage_threshold = DB.terrain_config[? "damage_threshold"];
outburst_threshold = DB.terrain_config[? "outburst_threshold"];
bounce_threshold = DB.terrain_config[? "bounce_threshold"];

bounce_speedchange_ratio = 2;
bounce_speedenergy_ratio = 0.1;
// ^

black_tint = DB.colormap[? g_black];

radius = 15;
scale_amount = 0;
scale_buffer = 0;
scale = 1;
scale_dist = 0;
max_scale_amount = 0;
max_scale_distance = 0;
unscale_speed = 0;

// for damage popup
obj_center_offset = true;
obj_center_xoff = radius;
obj_center_yoff = radius;

my_grid = singleton_obj.id;
my_list = noone;
grid_x = -1;
grid_y = -1;
aligned_x = x;
aligned_y = y;

if(instance_exists(gamemode_obj))
{
    if(my_grid.grid_width == 0 && my_grid.grid_height == 0)
    {
        terrain_grid_init(my_grid);
    }
    
    if(!instance_exists(chunkgrid_obj))
    {
        instance_create(0,0, chunkgrid_obj);
    }
    
    registered = terrain_register(my_grid, id);
}

near_walls = ds_map_create();
near_walls[? right] = noone;
near_walls[? up] = noone;
near_walls[? left] = noone;
near_walls[? down] = noone;
is_new = true;

alarm[2] = 2; 

regenerate_nav_graph(4);