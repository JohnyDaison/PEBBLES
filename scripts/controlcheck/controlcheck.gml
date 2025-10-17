/// @self guy_obj
/// @param {Real} input_method
/// @param {Real} state
/// @param {Real} control_id
/// @return {Any} Real for state = axis, otherwise Bool
function controlcheck(input_method, state, control_id) {
    if (input_method == cpu_control) {
        return false;
    }

    if (input_method == keyboard) {
        if (state == axis) {
            if (control_id == aim_x) {
                return self.control_obj.current_aim_x;
            }
            else if (control_id == aim_y) {
                return self.control_obj.current_aim_y;
            }
        }
        else if (state == free) {
            return (!keyboard_check((self.keys[? control_id])));
        }
        else if (state == pressed) {
            return keyboard_check_pressed((self.keys[? control_id]));
        }
        else if (state == held) {
            return keyboard_check((self.keys[? control_id]));
        }
        else if (state == released) {
            return keyboard_check_released((self.keys[? control_id]));
        }
    }

    if (input_method == gamepad) {
        if (instance_exists(self.control_obj)) {
            var gp_id = self.control_obj.binds[? control_id];

            if (state == axis) {
                if (control_id == aim_x) {
                    return self.control_obj.current_aim_x;
                }
                else if (control_id == aim_y) {
                    return self.control_obj.current_aim_y;
                }
            }
            else if (gp_id > 10) {
                if (state == free) {
                    return (!gamepad_button_check(self.control_obj.index, gp_id));
                }
                else if (state == pressed) {
                    return gamepad_button_check_pressed(self.control_obj.index, gp_id);
                }
                else if (state == held) {
                    return gamepad_button_check(self.control_obj.index, gp_id);
                }
                else if (state == released) {
                    return gamepad_button_check_released(self.control_obj.index, gp_id);
                }
            }
            else {
                if (is_undefined(gp_id)) {
                    return false;
                }

                return self.control_obj.states[# gp_id, state];
            }
        }
    }
}
