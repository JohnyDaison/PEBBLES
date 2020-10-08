action_inherited();
if(self.alpha > 0)
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    my_draw_set_font(self.font);
    
    draw_set_alpha(self.alpha);
    draw_set_color(c_gray);
    
    i=2;
    repeat(2)
    {
        my_draw_text_ext(x+width/2+i, y+height/2+i, string_hash_to_newline(message), line_height, width-32);
        
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


/* */
/*  */
