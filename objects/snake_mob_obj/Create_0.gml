my_grid = singleton_obj.id;
ter_group = instance_create(0,0, terrain_group_obj);
ter_group.front_insert = true;

my_player = gamemode_obj.environment;

travel_direction = -1;
last_dir = travel_direction;
travel_delay = 20;
turn_delay = 60;
head_size = 3;
body_size = 0;
unfreeze_distance = 1280;
obj_center_offset = false;

max_move_tries = 8;

blocked_dir = 1;
grid_sight_distance = 10;
eat_target = noone;

move_tries = 0;
has_turned = false;
alive = false;
done_for = false;
kill_awarded = false;
trophy_created = false;

body_col = irandom_range(g_red, g_azure);
my_color = body_col;
tint = DB.colormap[? my_color];
name = "Snake";

self.transform_memory = ds_map_create();
self.invisible = false;

alarm[1] = 320;
alarm[3] = alarm[1] + turn_delay;
//alarm[4] = 680;
alarm[0] = 1;
