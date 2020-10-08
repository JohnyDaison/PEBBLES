event_inherited();

if(self.alpha > 0)
{
    var item_center_x = x;
    var item_center_y = y+height/2;
    
    var item_border_x1 = item_center_x - scaled_halfwidth;
    var item_border_x2 = item_center_x + scaled_halfwidth - 1;
    var item_border_y1 = item_center_y - scaled_halfheight;
    var item_border_y2 = item_center_y + scaled_halfheight - 1;
    
    // ITEM BG
    draw_set_alpha(self.alpha*self.bg_alpha);
    draw_set_color(self.bg_color);
    draw_roundrect(item_border_x1,item_border_y1, item_border_x2,item_border_y2, false);
    
    // BORDER
    draw_set_alpha(self.alpha*self.border_alpha);
    draw_set_color(self.border_color);
    draw_roundrect(item_border_x1,item_border_y1, item_border_x2,item_border_y2, true);

    draw_set_color(self.border_highlight_color);
    draw_roundrect(item_border_x1,item_border_y1, item_border_x2,item_border_y2, true);
    
    // ITEM
    draw_sprite_ext(self.image, 0, item_center_x, item_center_y, item_scale, item_scale, 0, self.item_color, min(1, 2*self.alpha));
    
    
    // TEXTS
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    my_draw_set_font(self.font);
    
    draw_set_alpha(self.alpha*0.75);
    
    //draw_set_color(merge_colour(self.item_color, c_white, 0.5));
    draw_set_color(self.outline_color);
    
    
    // HEADING
    i = 2;
    repeat(2)
    {
        my_draw_text(x + scaled_halfwidth + text_width/2 + i,
                     y + 0.75*line_height + i,
                     self.title);
        /*
        draw_set_color(self.outline_color);                        
        if(i==2)
        {
            i = -2;
        }
        else
        {*/
            i = 0;
            draw_set_color(self.item_color); 
        //}
    }
    
    
    // DESCRIPTION
    draw_set_alpha(self.alpha);
    draw_set_color(c_gray);
    
    i=2;
    repeat(2)
    {
        
        my_draw_text_ext(x + scaled_halfwidth + text_width/2 + i,
                         y + height/2 + line_height/2 + i,
                         message,
                         line_height, text_width - 32);

        draw_set_color(self.color);                        
        i=0;
    }
}

/*
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
my_draw_set_font(self.font);
draw_set_color(c_white);
my_draw_text(x,y+height, string(blink_step) + " " + string(alpha) + " " + string(fadeout_step) + " " + string(width) + " " + string(height) + " " + title);
*/
