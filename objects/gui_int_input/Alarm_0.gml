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

self.up_arrow = gui_add_button(x+dial.width/2+9,y-8,"",gui_int_input_script,true);
up_arrow.width = 14;
up_arrow.height = 14;
up_arrow.icon = tiny_nice_up_arrow_spr;
up_arrow.enabled_icon_color = merge_color(c_lime, c_white, 0.5);
up_arrow.show_icon = true; 
up_arrow.center_icon = true; 
up_arrow.button_function = "up";
up_arrow.left_hand_object = dial;

self.down_arrow = gui_add_button(x+dial.width/2+9,y+8,"",gui_int_input_script,true);
down_arrow.width = 14;
down_arrow.height = 14;
down_arrow.icon = tiny_nice_down_arrow_spr;
down_arrow.enabled_icon_color = merge_color(c_lime, c_white, 0.5);
down_arrow.show_icon = true;
down_arrow.center_icon = true; 
down_arrow.button_function = "down";
down_arrow.left_hand_object = dial;

self.width = dial.width+2*16;
self.height = 32;
