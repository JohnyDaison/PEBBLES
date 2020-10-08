event_inherited();

self.base_bg_color = c_ltgray;
self.bg_color = self.base_bg_color;
self.base_text_color = c_black;
//self.select_text_color = c_black;
self.max_digits = 3;
self.digit_width = 16;
self.value = 0;
self.max_value = power(10, max_digits) - 1;
self.min_value = -self.max_value;
self.is_int_input = false;
self.is_percent = false;
self.value_step = 1;