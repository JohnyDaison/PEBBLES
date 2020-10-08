var cur_offset = xoffset;
var cur_alpha = image_alpha;

repeat(vice_count)
{
    draw_sprite_ext(suppresion_effect_spr,0, x-cur_offset,y, -1,1,0, tint, cur_alpha);

    draw_sprite_ext(suppresion_effect_spr,0, x+cur_offset,y, 1,1,0, tint, cur_alpha);
    
    cur_offset += vice_dist;
    cur_offset = ((cur_offset-xmin) mod (xmax-xmin))+xmin;
    
    cur_alpha -= image_alpha/vice_count;
}

