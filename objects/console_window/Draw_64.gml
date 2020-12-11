window_axis = x+self.width/2;

if(focused)
{
    focus_modifier = 1;
}
else
{
    focus_modifier = 0.5;
}


if(self.draw_bg_color)
{
    var x2 = x+self.width;
    var y2 = y+self.height;
    
    draw_set_alpha(self.alpha*self.border_alpha*focus_modifier);
    draw_set_color(self.border_color);
    draw_rectangle(x-1,y2-1, x2+1,y2+1, false);
    
    draw_set_alpha(self.alpha*self.bg_alpha*focus_modifier);
    draw_set_color(self.bg_color);
    draw_rectangle(x,y, x2,y2, false);
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
my_draw_set_font(label_font);

my_draw_text(x+1,y, string(fps));
my_draw_text(x+64,y, string(round(fps_real)));

