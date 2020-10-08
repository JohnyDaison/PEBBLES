// BURST ANIM
if(burst_anim_sprite == universal_pad_burst_loop_spr)
{
    draw_sprite_ext(burst_anim_sprite, (burst_anim_index + 4) mod burst_anim_length, x,y, -1,1, 0, burst_tint, image_alpha/2);
}

// PAD BASE
draw_set_color(c_white);
draw_sprite(sprite_index,image_index,x,y);

// PAD BODY
draw_sprite_ext(jump_pad_top_spr,0,x,y,1,1,0,self.tint,image_alpha);

// GLOW
if(pad_color > g_black)
{   
    draw_sprite_ext(jump_pad_top_spr,1,x,y,1,cur_power/max_power,0,self.tint,image_alpha);
}

event_inherited();
