draw_self();

if (flag_icon != noone) {
    var flag_tint = decide_flag_tint(my_player, gamemode_obj.find_player_by_view(view_current));

    if (has_flag) {
        var own_flag_fade_alpha = 1;
        var captured_flag_fade_alpha = 0;
        
        if (captured_flag_icon != noone) {
            var captured_flag_tint = decide_flag_tint(captured_flag_player, gamemode_obj.find_player_by_view(view_current));
            var anim_ends_distance = min(captured_anim_phase, captured_anim_duration - captured_anim_phase);
            captured_flag_fade_alpha = min(1, anim_ends_distance / captured_anim_fade_duration);
            own_flag_fade_alpha = 1 - captured_flag_fade_alpha;
        }
        
        if (own_flag_fade_alpha > 0) {
            draw_sprite_ext(flag_icon, 0, x, y - 40, 1, 1, 0, flag_tint, flag_alpha*own_flag_fade_alpha);
        }
        
        if (captured_flag_fade_alpha > 0) {
            draw_sprite_ext(captured_flag_icon, 0, x, y - 40, 1, 1, 0, captured_flag_tint, flag_alpha*captured_flag_fade_alpha);
        }
        
        draw_sprite_ext(tiny_flag_capsule_spr, 0, x, y, 1, 1, 0, c_white, 1);
    } else {
        draw_sprite_ext(flag_spawner_static_noise_spr, static_anim_phase, x, y - 40, 1, 1, 0, c_white, flag_alpha);
    }

    draw_sprite_ext(flag_icon, 0, x - 45, y, 0.5, 0.5, 0, flag_tint, flag_alpha);

    draw_sprite_ext(flag_icon, 0, x + 45, y, 0.5, 0.5, 0, flag_tint, flag_alpha);
}

event_inherited();
