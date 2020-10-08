draw_sprite_ext(mob_portal_spr, 0, x, y, scale, scale, angle, c_white, alpha);

if(activated && respawning)
{
    draw_sprite_ext(sprite_index, image_index, x,y, hor_size, 1, 0, singleton_obj.octarine_tint, image_alpha);
    
    /*
    if(seconds_left > 0)
    {
        my_draw_set_font(text_popup_font);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        draw_set_colour(c_orange);
        my_draw_text(x,y - 4, string( seconds_left ));
    }
    */
}