image_xscale = (width+1)/mask_size;
image_yscale = (height+1)/mask_size;
if(horizontal)
{
    image_yscale = (2*stop_dist+1)/mask_size;   
    draw_sprite_ext(beam_base, 0, x-width/2-1, y-height,   (width+1)/texture_size,  height/texture_size, 0, tint, alpha);
    draw_sprite_ext(beam_base, 0, x-width/2-1, y+height-1, (width+1)/texture_size, -height/texture_size, 0, tint, alpha);
}
else if(vertical)
{
    image_xscale = (2*stop_dist+1)/mask_size;  
    draw_sprite_ext(beam_base, 0, x-width+1, y+height/2, (height+1)/texture_size, (width-1)/texture_size, 90, tint, alpha);
    draw_sprite_ext(beam_base, 0, x+width-1, y+height/2, (height+1)/texture_size, -width/texture_size, 90, tint, alpha);
}
else
{
    draw_sprite_ext(beam_base, 0, x-texture_size/2-1, y-texture_size,   1,  1, 0, tint, alpha);
    draw_sprite_ext(beam_base, 0, x-texture_size/2-1, y+texture_size-1, 1, -1, 0, tint, alpha);    
}

/*
draw_set_colour(c_red);
draw_rectangle(x-width/2-2, y-height/2-1, x+width/2-2, y+height/2-1,true);
*/
//draw_self();
/*
draw_set_colour(c_green);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
*/

event_inherited();
