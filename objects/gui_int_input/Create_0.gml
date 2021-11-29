event_inherited();

self.cur_sign = 1;
self.max_digits = 3;
self.value = 0;
self.last_value = 0;
self.min_value = 0;
self.max_value = 0;
self.is_percent = false;
self.value_step = 1;
self.locked = false;

self.dial = noone;
self.minus_box = noone;

self.onchange_script = empty_script;

alarm[0] = 1;

set_value = function(new_value, supress_onchange) {
    if (dial.set_value(new_value)) {
        last_value = value;
        value = cur_sign * dial.value;
        if (!is_undefined(supress_onchange) && supress_onchange) {
            last_value = value;
        }
        
        return true;
    }
    
    return false;
}
