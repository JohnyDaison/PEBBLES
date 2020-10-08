action_inherited();
//trigger_group_id = "roguelike/triggers";
//trigger_group = noone;

//anim_group_count = 0;

center_x = room_width/2;
center_y = room_height/2;
center_x -= center_x mod 32;
center_y -= center_y mod 32;

instance_create(center_x, center_y, main_camera_obj);
instance_create(center_x, center_y, level_start_obj);
instance_create(center_x, center_y + 32, platform_obj);
instance_create(center_x - 32, center_y + 64, wall_obj);
instance_create(center_x, center_y + 64, wall_obj);