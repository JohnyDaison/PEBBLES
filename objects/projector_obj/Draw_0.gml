for(i=0; i<4; i++)
{
    if(enabled[?i])
    {
        var xx = 1, xcor = 0;
        var yy = 1, ycor = 0;
        if(i==1)
            ycor = 1;   
        if(i==2)
            xcor = 1;
        if(i>1)
            xx = -1;
                   
        draw_sprite_ext(sprite_index, image_index, x+xcor,y+ycor, xx,yy, (i mod 2)*90, tint, 1);
        
        if(powered)
        {
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            my_draw_set_font(small_font);
            
            var width = string_width(string_hash_to_newline(text)) +16,
                halfwidth = floor(width/2);
            var xx = x + text_x;
            var yy = y + text_y;

            draw_set_alpha(0.2);
            draw_set_colour(c_white);
            draw_roundrect(xx - halfwidth, yy -15,
                 xx + halfwidth, yy +15, false);
            
            draw_set_alpha(0.7);
            
            draw_set_colour(tint);
            my_draw_text(xx-1, yy-1, string_hash_to_newline(text));
            my_draw_text(xx+1, yy+1, string_hash_to_newline(text));
            
            draw_set_colour(c_white);
            my_draw_text(xx, yy, string_hash_to_newline(text));
        }

        draw_set_alpha(1);
    }
}

action_inherited();
