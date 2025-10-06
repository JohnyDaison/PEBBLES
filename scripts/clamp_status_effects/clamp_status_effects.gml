function clamp_status_effects() {
    for (var i = 0; i < DB.status_effect_count; i++) {
        var effect_id = DB.status_effects_list[| i];
        var effect = DB.status_effects[? effect_id];

        if (self.status_left[? effect_id] <= 0) {
            self.status_left[? effect_id] = 0;
            if (self.status_start[? effect_id] != -1) {
                script_execute(effect.end_script);
                self.status_start[? effect_id] = -1;
            }
        }
        else if (self.status_start[? effect_id] == -1) {
            self.status_start[? effect_id] = self.step_count;
            script_execute(effect.start_script);
        }

        if (self.status_left[? effect_id] > effect.max_charge) {
            self.status_left[? effect_id] = effect.max_charge;
        }
    }
}
