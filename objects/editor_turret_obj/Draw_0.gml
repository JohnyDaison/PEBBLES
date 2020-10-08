draw_set_color(c_white);
draw_sprite_ext(turret_mount_spr,direction/90,x,y,1,1,0,c_white,1);
draw_sprite_ext(turret_body_spr,0,x+15,y+15,1,1,0,c_white,image_alpha);

action_inherited();
