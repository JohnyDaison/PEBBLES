draw_set_alpha(1);
draw_self();

draw_set_color(c_yellow);
draw_roundrect_ext(x+2,y+2, x + 9, y + 19, 8, 8, false);

if(dragged)
{
    draw_set_color(c_white);
    my_draw_set_font(bigger_label_font);
    draw_text(x - 16, y - 32, "D");
}