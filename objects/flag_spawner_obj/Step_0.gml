event_inherited();

if (captured_flag_icon != noone) {
    captured_anim_phase += 1;

    set_lights_state(floor(captured_anim_phase/captured_anim_blink_time) mod 2);

    if (captured_anim_phase >= captured_anim_duration) {
        captured_flag_icon = noone;
        captured_flag_player = noone;
        set_lights_state(false);
    }
}

static_anim_phase += static_anim_speed;
if (static_anim_phase >= static_anim_length) {
    static_anim_phase = 0;
}

gives_light = has_flag;