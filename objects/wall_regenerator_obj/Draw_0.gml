if(sprite_index != no_sprite)
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
        if(my_color != g_dark || !tint_updated)
        {
            final_tint = merge_color(black_tint,self.tint, 0.5+min(energy/outburst_threshold,1)*0.5);   
        }
        
        draw_sprite_ext(sprite_index,image_index, x,y, 1,1,0, final_tint,image_alpha);
    }
}