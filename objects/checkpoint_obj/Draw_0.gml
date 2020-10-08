if(!invisible)
{
    draw_set_alpha(holo_alpha);
    draw_self();
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    my_draw_set_font(label_font);
    draw_set_colour(c_white);
    my_draw_text(x,y-32,name);
}

