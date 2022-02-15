self.dial = gui_add_int_dial(x,y,round(value));
dial.max_digits = self.max_digits;
dial.is_int_input = true;
dial.tooltip = self.tooltip;
dial.is_percent = self.is_percent;
dial.value_step = self.value_step;
dial.custom_width = self.custom_width;
dial.draw_thick_border = self.draw_thick_border;
dial.thick_border_size = self.thick_border_size;
dial.height = self.height;
dial.base_bg_color = self.base_bg_color;
dial.bg_color = dial.base_bg_color;
dial.disabled_color = self.disabled_color;

if (!self.custom_width) {
    dial.width = dial.max_digits * dial.digit_width;
}

self.minus_box = gui_add_button(x-dial.width/2-9,y,"",gui_int_input_script);
minus_box.width = 14;
minus_box.height = self.height;
minus_box.button_function = "sign_switch";

if (!self.custom_width) {
    self.width = dial.width;
} else {
    dial.width = self.width;
}
