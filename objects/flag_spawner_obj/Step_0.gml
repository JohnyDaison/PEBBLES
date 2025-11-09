event_inherited();

if (self.captured_flag_icon != noone) {
    self.captured_anim_phase += 1;

    set_lights_state(floor(self.captured_anim_phase / self.captured_anim_blink_time) mod 2);

    if (self.captured_anim_phase >= self.captured_anim_duration) {
        self.captured_flag_icon = noone;
        self.captured_flag_player = noone;
        set_lights_state(false);
    }
}

self.static_anim_phase += self.static_anim_speed;

if (self.static_anim_phase >= self.static_anim_length) {
    self.static_anim_phase = 0;
}

self.gives_light = self.has_flag;
