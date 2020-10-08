// CORE
if(sprite_index != noone)
{
    if(self.custom_sprite)
    {
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_sprite(sprite_index,image_index,x,y);    
    }
    else
    {    
        var final_tint = self.tint;
        if(my_color != g_black || !tint_updated)
        {
            final_tint = merge_color(black_tint,self.tint, 0.5+min(energy/outburst_threshold,1)*0.5);   
        }
        if(do_glow)
        {
            var offset;
            if(strong_glow)
            {
                offset = 0.5;
            }
            else
            {
                offset = 0;
            }
            final_tint = merge_color(final_tint,c_white, offset+min(energy/outburst_threshold,1)*0.5);
        }
        
        image_index = max(0,image_index);
        
        draw_sprite_ext(sprite_index,image_index, x+scale_dist,y+scale_dist, scale,scale,0, final_tint,image_alpha);
        /*
        if(do_glow)
        {
            draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_white,0.5);    
        }
        */
    }
}

// COVER
if(cover_spr != noone && cover_color > -1 && cover_tint > -1)
{
    draw_sprite_ext(cover_spr,image_index, x+scale_dist,y+scale_dist, scale,scale,0, cover_tint,image_alpha);
}
