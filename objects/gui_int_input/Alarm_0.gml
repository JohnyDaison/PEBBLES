self.dial = gui_add_int_dial(x,y,round(value));
dial.max_digits = self.max_digits;
dial.width = dial.max_digits*dial.digit_width;
dial.is_int_input = true;
dial.tooltip = self.tooltip;
dial.is_percent = self.is_percent;
dial.value_step = self.value_step;

self.minus_box = gui_add_button(x-dial.width/2-9,y,"",gui_int_input_script);
minus_box.width = 14;
minus_box.height = 32;
minus_box.button_function = "sign_switch";

self.width = dial.width;
self.height = 32;
