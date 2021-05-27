function controlcheck(input_method, state, control_id) {
    if(input_method == cpu_control)
    {
        return false;
    }

    if(input_method == keyboard)
    {
        if(state == axis)
        {
            if(control_id == aim_x)
            {
                return control_obj.current_aim_x;
            }
            else if(control_id == aim_y)
            {
                return control_obj.current_aim_y;
            }
        }
        else if(state == free)
        {
            return (!keyboard_check((self.keys[? control_id])));
        }
        if(state == pressed)
        {
            return keyboard_check_pressed((self.keys[? control_id]));
        }
        if(state == held)
        {
            return keyboard_check((self.keys[? control_id]));
        }
        if(state == released)
        {
            return keyboard_check_released((self.keys[? control_id]));
        }
    }

    if(input_method == gamepad)
    {
        if(instance_exists(control_obj))
        {
            var gp_id = control_obj.binds[? control_id];
        
            if(state == axis)
            {
                if(control_id == aim_x)
                {
                    return control_obj.current_aim_x;
                }
                else if(control_id == aim_y)
                {
                    return control_obj.current_aim_y;
                }
            }
            else if(gp_id > 10)
            {
                if(state == free)
                {
                    return (!gamepad_button_check(control_obj.index, gp_id));
                }
                if(state == pressed)
                {
                    return gamepad_button_check_pressed(control_obj.index, gp_id);
                }
                if(state == held)
                {
                    return gamepad_button_check(control_obj.index, gp_id);
                }
                if(state == released)
                {
                    return gamepad_button_check_released(control_obj.index, gp_id);
                }
            }
            else
            {
                if(is_undefined(gp_id))
                {
                    return false;   
                }
                return control_obj.states[# (gp_id), state];
            }
        }
    }
}
