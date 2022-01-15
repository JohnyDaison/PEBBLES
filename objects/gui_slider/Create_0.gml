event_inherited();

base_bg_color = c_ltgray;
bg_color = base_bg_color;
base_text_color = c_black;
bar_color = c_green;
value = 0;
max_value = 10;
min_value = 0;
bar_max_value = 10;
bar_min_value = 0;
value_step = 1;
want_focus = true;
round_corners = true;
draw_border = true;

set_value = function(new_value) {
    if(is_undefined(new_value)) {
        return false;
    }
    
    value = min_value + round((new_value - min_value) / value_step) * value_step;
    value = clamp(value, min_value, max_value);
    
    return true;
}