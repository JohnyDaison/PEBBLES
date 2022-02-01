draw_self();

if (flag_icon != noone) {
    var flag_tint = decide_flag_tint(my_player, gamemode_obj.find_player_by_view(view_current));

    if (has_flag) {
        draw_sprite_ext(flag_icon, 0, x, y - 40, 1, 1, 0, flag_tint, flag_alpha);
    }

    draw_sprite_ext(flag_icon, 0, x - 45, y, 0.5, 0.5, 0, flag_tint, flag_alpha);

    draw_sprite_ext(flag_icon, 0, x + 45, y, 0.5, 0.5, 0, flag_tint, flag_alpha);
}

event_inherited();
