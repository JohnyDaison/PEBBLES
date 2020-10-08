draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,tint,image_alpha*holo_alpha);

//var texture = sprite_get_texture(burst_gradient_spr,0);
draw_primitive_begin(pr_trianglestrip);

draw_vertex_colour(x1,y1, tint, image_alpha*0.2*holo_alpha);
draw_vertex_colour(x2,y2, tint, image_alpha*0.2*holo_alpha);
draw_vertex_colour(x3,y3, tint, 0);
draw_vertex_colour(x4,y4, tint, 0);

draw_primitive_end();


event_inherited();
