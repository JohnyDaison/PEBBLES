draw_set_color(c_white);
draw_sprite(jump_pad_base_spr,image_index,x+spr_xoffset,y+spr_yoffset);
draw_sprite_ext(jump_pad_top_spr,round(ready),x+spr_xoffset,y+spr_yoffset,1,1,0,final_tint,image_alpha);

action_inherited();
