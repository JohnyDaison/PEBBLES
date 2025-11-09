draw_self();

if (self.flag_icon == noone) {
    event_inherited();
    exit;
}

var flag_tint = decide_flag_tint(self.my_player, gamemode_obj.find_player_by_view(view_current));

if (self.has_flag) {
    var own_flag_fade_alpha = 1;
    var captured_flag_fade_alpha = 0;
    var captured_flag_tint = c_white;

    if (self.captured_flag_icon != noone) {
        captured_flag_tint = decide_flag_tint(self.captured_flag_player, gamemode_obj.find_player_by_view(view_current));
        var anim_ends_distance = min(self.captured_anim_phase, self.captured_anim_duration - self.captured_anim_phase);
        captured_flag_fade_alpha = min(1, anim_ends_distance / self.captured_anim_fade_duration);
        own_flag_fade_alpha = 1 - captured_flag_fade_alpha;
    }

    if (own_flag_fade_alpha > 0) {
        draw_sprite_ext(self.flag_icon, 0, self.x, self.y - 40, 1, 1, 0, flag_tint, self.flag_alpha * own_flag_fade_alpha);
    }

    if (captured_flag_fade_alpha > 0) {
        draw_sprite_ext(self.captured_flag_icon, 0, self.x, self.y - 40, 1, 1, 0, captured_flag_tint, self.flag_alpha * captured_flag_fade_alpha);
    }

    draw_sprite_ext(tiny_flag_capsule_spr, 0, self.x, self.y, 1, 1, 0, c_white, 1);
} else {
    draw_sprite_ext(flag_spawner_static_noise_spr, self.static_anim_phase, self.x, self.y - 40, 1, 1, 0, c_white, self.flag_alpha);
}

draw_sprite_ext(self.flag_icon, 0, self.x - 45, self.y, 0.5, 0.5, 0, flag_tint, self.flag_alpha);

draw_sprite_ext(self.flag_icon, 0, self.x + 45, self.y, 0.5, 0.5, 0, flag_tint, self.flag_alpha);

event_inherited();
