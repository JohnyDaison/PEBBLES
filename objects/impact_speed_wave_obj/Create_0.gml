event_inherited();

system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, 20);
part_system_draw_order(system, true);

particle_end_alpha = 0.1;
particle_color = c_white;
particle_shape = pt_shape_line;
particle_size = 0.3;
particle_life = 25;
particle_max_rotation = 90;
particle_xoffset_start = 8;
particle_yoffset_start = 32;
particle_move_distance = 36;

particle_rotation_step = particle_max_rotation / particle_life;
particle_speed = particle_move_distance / particle_life;


pt = part_type_create();
part_type_alpha2(pt, 1, particle_end_alpha);
part_type_blend(pt, false);
part_type_color1(pt, particle_color);
part_type_shape(pt, particle_shape);
part_type_size(pt, particle_size, particle_size, 0, 0);
part_type_life(pt, particle_life, particle_life);
part_type_speed(pt, particle_speed, particle_speed, 0, 0);
part_type_direction(pt, 180, 180, 0, 0);
part_type_orientation(pt, 0, 0, -particle_rotation_step, 0, false);


pt2 = part_type_create();
part_type_alpha2(pt2, 1, particle_end_alpha);
part_type_blend(pt2, false);
part_type_color1(pt2, particle_color);
part_type_shape(pt2, particle_shape);
part_type_size(pt2, particle_size, particle_size, 0, 0);
part_type_life(pt2, particle_life, particle_life);
part_type_speed(pt2, particle_speed, particle_speed, 0, 0);
part_type_direction(pt2, 0, 0, 0, 0);
part_type_orientation(pt2, 0, 0, particle_rotation_step, 0, false);

em = part_emitter_create(system);
