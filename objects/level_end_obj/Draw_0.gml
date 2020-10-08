draw_set_color(c_white);
my_draw_set_font(label_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y - 48, "EXIT");


//draw_sprite_ext(level_exit_spr, 0, x, y, scale, scale, 0, singleton_obj.octarine_tint, 0.8);

draw_sprite_ext(level_exit2_spr, 0, x, y, 1, 1, 0, c_white, 0.8);

if(prepare_anim_phase > 0)
{
    var prep_ratio = prepare_anim_phase/exit_anim_prepare_time;
    draw_sprite_ext(mob_portal_spr, 0, x, y, scale*prep_ratio, scale*prep_ratio, angle, c_white, 0.95);
}

