/// @description controlcheck(input_method,state,control_id)
/// @function controlcheck
/// @param input_method
/// @param state
/// @param control_id
function controlcheck(argument0, argument1, argument2) {
	var input_method = argument0;
	var state = argument1;
	var control_id = argument2;

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

	/*
	if(input_method == joystick)
	{
	    if((control_id < joy_none && control_id >= 0))
	    {
	        if(self.control_set == joypad1)
	        {
	            return joystick1_obj.states[# (self.joys[? control_id]),state];
	        }
	        if(self.control_set == joypad2)
	        {
	            return joystick2_obj.states[# (self.joys[? control_id]),state];
	        }
        
	    }
	    if(control_id == joy_none)
	    {
	        checked = 0;
	        passed = 0;
	        for(i=1;i<joy_none;i+=1)
	        {
	            if(i < 11 || i >= 20)
	            {
	                checked+=1;
	                if(self.control_set == joypad1)
	                {
	                    if(!joystick1_obj.states[# (self.joys[? control_id]),state])
	                        passed+=1;
	                }
	                if(self.control_set == joypad2)
	                {
	                    if(!joystick2_obj.states[# (self.joys[? control_id]),state])
	                        passed+=1;
	                }
	            }
	        }
	        return (checked == passed);
	    }
	    if(control_id == joy_any)
	    {
	        passed=0;
	        for(i=1;i<joy_none;i+=1)
	        {
	            if(i < 11 || i >= 20)
	            {
	                if(self.control_set == joypad1)
	                {
	                    if(joystick1_obj.states[# (self.joys[? control_id]),state])
	                        return true;
	                }
	                if(self.control_set == joypad2)
	                {
	                    if(joystick2_obj.states[# (self.joys[? control_id]),state])
	                        return true;
	                }
	            }
	        }
	        return false;
	    }
	}
	*/

	if(input_method == gamepad)
	{
	    if(instance_exists(control_obj))
	    {
	        gp_id = control_obj.binds[? control_id];
        
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
