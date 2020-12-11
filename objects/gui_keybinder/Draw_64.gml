if(!centered)
{
    x=x-width/2;
    y=y-height/2;
    centered = true;
}

draw_set_alpha(bg_alpha);
if(self.draw_bg_color)
{
    draw_set_color(self.bg_color);
    if(round_corners)
    {
        draw_roundrect(x,y,x+self.width,y+self.height,false);
    }
    else
    {
        draw_rectangle(x,y,x+self.width,y+self.height,false);
    }
}
draw_set_alpha(self.border_alpha);
if(self.draw_border)
{
    draw_set_color(self.border_color);
    if(round_corners)
    {
        draw_roundrect(x,y,x+self.width,y+self.height,true);
    }
    else
    {
        draw_rectangle(x,y,x+self.width,y+self.height,true);
    }
}
draw_set_alpha(1);
draw_set_color(self.color);
my_draw_set_font(self.font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var key_press_offset = 0;

if(key_down)
{
    key_press_offset = 0;
    image_index = 1;
}
else
{
    key_press_offset = -2;
    image_index = 0;
}

key_offset = key_base_offset + key_press_offset;

text_width = string_width(key_text);

cent_x = x+self.width/2;
cent_y = y+self.height/2;

text_start = cent_x - ceil(text_width/2);
text_width = max(1,text_width);
text_end = text_start + text_width;

hor_offset = 0;

draw_sprite(keyback_l,0,text_start-16,y);
draw_sprite_ext(keyback_m,0,text_start,y,text_width,1,0,c_white,1);
draw_sprite(keyback_r,0,text_end,y);

if(key_down)
{
    draw_sprite(keydown_l,0,text_start-16,y);
    draw_sprite_ext(keydown_m,0,text_start,y,text_width,1,0,c_white,1);
    draw_sprite(keydown_r,0,text_end,y);
}
else
{
    draw_sprite(keyup_l,0,text_start-16,y);
    draw_sprite_ext(keyup_m,0,text_start,y,text_width,1,0,c_white,1);
    draw_sprite(keyup_r,0,text_end,y);
}

my_draw_text(cent_x + hor_offset, cent_y + key_offset, self.key_text);
