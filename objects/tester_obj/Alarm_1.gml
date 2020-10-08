/// @description COLLISION LINE LIST

var test_list = ds_list_create();

var start_inbuilt_time = current_time;

repeat(10000)
{
    collision_line_list(0,0, room_width, room_height, solid_terrain_obj, false, false, test_list, false);
    collision_line_list(random(room_width), random(room_height), random(room_width), random(room_height), solid_terrain_obj, false, false, test_list, false);
}

var end_inbuilt_time = current_time;

var start_my_time = current_time;

repeat(10000)
{
    my_collision_line_list(0,0, room_width, room_height, solid_terrain_obj, false, false, test_list, false);
}

var end_my_time = current_time;

my_console_log("Inbuilt time: " + string(start_inbuilt_time) + " - " + string(end_inbuilt_time) + " : " + string(end_inbuilt_time - start_inbuilt_time));

my_console_log("My time: " + string(start_my_time) + " - " + string(end_my_time) + " : " + string(end_my_time - start_my_time));

ds_list_destroy(test_list);