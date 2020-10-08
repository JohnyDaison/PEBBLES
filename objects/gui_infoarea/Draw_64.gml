if(!centered)
{
    x = x-width/2;
    y = y-height/2;
    centered = true;
}
draw_set_alpha(bg_alpha);
if(self.draw_bg_color)
{
    draw_set_color(self.bg_color);
    draw_rectangle(x,y,x+self.width,y+self.height,false)
}
draw_set_alpha(self.border_alpha);
if(self.draw_border)
{
    draw_set_color(self.border_color);
    draw_rectangle(x,y,x+self.width,y+self.height,true)
}
draw_set_alpha(1);
my_draw_set_font(self.font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_gray - self.color);

i=1;
repeat(2)
{
    my_draw_text_ext(x+self.width/2+i,y+self.height/2+i,string_hash_to_newline(self.text),28,self.width-16);
    i=0;
    draw_set_color(self.color);
}

