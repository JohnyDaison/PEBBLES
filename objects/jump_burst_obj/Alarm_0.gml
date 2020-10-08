pt = part_type_create();
part_type_sprite(pt,part_pixel_spr,0,0,0);
part_type_size(pt,1,1,0,0);
part_type_scale(pt,1,1);
part_type_color1(pt,c_white);
part_type_alpha2(pt,0.8*charge_ratio,0);
part_type_speed(pt,1.8*charge_ratio,2.5*charge_ratio,-0.10,0);
part_type_direction(pt,min_dir,max_dir,0,0);
part_type_gravity(pt,0,180);
part_type_orientation(pt,0,0,0,0,0);
part_type_blend(pt,1);
part_type_life(pt,max_life-10,max_life*charge_ratio);

em = part_emitter_create(system);
part_emitter_region(system,em,x-2,x+2,y-2,y+2,ps_shape_ellipse,1);
part_emitter_burst(system,em,pt,particle_count*charge_ratio);

active = false;
alarm[1] = max_life*charge_ratio;

