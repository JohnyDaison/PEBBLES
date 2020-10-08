event_inherited();

draw_ambient = true;
draw_direct = false; // false

/*
ambient_light_coef = 0.2; // 1
direct_light_coef = 0;
*/

ambient_light_circle_coef = 0.2; // 1 0.2
direct_light_circle_coef = 0;
ambient_light_rectangle_coef = 0.2; // 1
direct_light_rectangle_coef = 0;

ambient_radius_coef = 4.5 * circle_base_size; // 30 5
direct_radius_coef = 0;
ambient_rectangle_coef = 4 * rectangle_base_size;
direct_rectangle_coef = 0;

light_layer = "bg";

