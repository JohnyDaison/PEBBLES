event_inherited();
/*
system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, 20);
part_system_draw_order(system, true);
pt = part_type_create();
part_type_alpha2(pt,0.2,1);
part_type_blend (pt,0);

part_type_color1(pt,DB.colormap[? g_magenta]);
part_type_shape (pt,pt_shape_line);
part_type_size(pt,0.8,0.8,0,0);
part_type_life(pt,12,12);
part_type_gravity(pt,0.5,270);


part_type_orientation(pt,0,0,0,0,0);
em = part_emitter_create(system);
*/

tint = DB.colormap[? g_magenta];
image_alpha = 0.75;

xmin = 5;
xmax = 20; 
xoffset = xmax;

animspeed = 1;
vice_count = 3;
vice_dist = 5;
