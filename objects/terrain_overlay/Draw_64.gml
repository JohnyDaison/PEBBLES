action_inherited();
draw_set_halign(fa_left);
draw_set_valign(fa_top);
my_draw_set_font(ter_font);

for(yy=0; yy<grid_height; yy+=1)
{
    draw_set_color(c_dkgray);
    my_draw_text(x+9,y+(yy*18)+9,string_hash_to_newline(self.ter_text[yy]));
    draw_set_color(c_white);
    my_draw_text(x+8,y+(yy*18)+8,string_hash_to_newline(self.ter_text[yy]));
}

