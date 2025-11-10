event_inherited();

if (self.blink_step < self.blink_time) {
    var blink_ratio;
    self.blink_step++;

    if (self.blink_step <= self.blink_peak) {
        blink_ratio = self.blink_step / self.blink_peak;
    }
    else {
        blink_ratio = 1 - (self.blink_step - self.blink_peak) / (self.blink_time - self.blink_peak);
    }

    self.alpha = self.orig_alpha;
    self.bg_color = merge_color(self.orig_bg_color, self.blink_color, blink_ratio);
}

if (self.fadeout_step < self.fadeout_time) {
    self.fadeout_step++;

    self.alpha = 1 - self.fadeout_step / self.fadeout_time;
    if (self.alpha <= 0) {
        self.message = "";
        self.fadeout_step = self.fadeout_time;
        self.alpha = 0;
    }
}

if (self.message == "") {
    self.cur_message_step = 0;
}
else {
    self.cur_message_step += 1;
}
