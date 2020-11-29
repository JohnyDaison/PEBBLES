function init_controls_DB() {
    var i, ii, init_val;
    
    // CONTROLS
	mouse_has_moved = false;
	keynames = ds_map_create();
	joynames = ds_map_create();
	padnames = ds_map_create();

	keynames[? vk_left] =  "Left";
	keynames[? vk_right] =  "Right";
	keynames[? vk_up] =  "Up";
	keynames[? vk_down] =  "Down";
	keynames[? vk_enter] =  "Enter";
	keynames[? vk_escape] =  "Esc";
	keynames[? vk_space] =  "Space";
	keynames[? vk_shift] =  "Shift";
	keynames[? vk_control] =  "Ctrl";
	keynames[? vk_alt] =  "Alt";
	keynames[? vk_backspace] =  "Backspace";
	keynames[? vk_tab] =  "Tab";
	keynames[? vk_home] =  "Home";
	keynames[? vk_end] =  "End";
	keynames[? vk_delete] =  "Delete";
	keynames[? vk_insert] =  "Insert";
	keynames[? vk_pageup] =  "Page Up";
	keynames[? vk_pagedown] =  "Page Down";
	keynames[? vk_pause] =  "Pause";
	keynames[? vk_printscreen] =  "PrtScr";
	i=0;
	repeat(12)
	{
	    keynames[? vk_f1+i] =  "F"+string(i+1);
	    i+=1;
	}

	i=0;
	repeat(10)
	{
	    keynames[? 48+i] =  string(i);
	    i+=1;
	}
	i=0;
	repeat(10)
	{
	    keynames[? vk_numpad0+i] =  "NUM"+string(i);
	    i+=1;
	}

	keynames[? vk_multiply] =  "NUM*";
	keynames[? vk_divide] =  "NUM/";
	keynames[? vk_add] =  "NUM+";
	keynames[? vk_subtract] =  "NUM-";
	keynames[? vk_decimal] =  "NUM.";
	keynames[? vk_lshift] =  "L Shift";
	keynames[? vk_lcontrol] =  "L Ctrl";
	keynames[? vk_lalt] =  "L Alt";
	keynames[? vk_rshift] =  "R Shift";
	keynames[? vk_rcontrol] =  "R Ctrl";
	keynames[? vk_ralt] =  "R Alt";

	keynames[? 186] =  ";";
	keynames[? 187] =  "=";
	keynames[? 188] =  ",";
	keynames[? 189] =  "-";
	keynames[? 190] =  ".";
	keynames[? 191] =  "/";
	keynames[? 192] =  "`";

	keynames[? 219] =  "[";
	keynames[? 220] =  "\\";
	keynames[? 221] =  "]";
	keynames[? 222] =  "'";

	// JOYSTICKS NAMES
	joynames[? joy_up] =  "Stick Up";
	joynames[? joy_down] =  "Stick Down";
	joynames[? joy_left] =  "Stick Left";
	joynames[? joy_right] =  "Stick Right";
	joynames[? joy_dpad_up] =  "D-Pad Up";
	joynames[? joy_dpad_down] =  "D-Pad Down";
	joynames[? joy_dpad_left] =  "D-Pad Left";
	joynames[? joy_dpad_right] =  "D-Pad Right";
	joynames[? joy_rtrigger] =  "R Trigger";
	joynames[? joy_ltrigger] =  "L Trigger";
	joynames[? joy_look] =  "Joy Look";

	joynames[? 1] =  "(A)";
	joynames[? 2] =  "(B)";
	joynames[? 3] =  "(X)";
	joynames[? 4] =  "(Y)";
	joynames[? 5] =  "L Bumper";
	joynames[? 6] =  "R Bumper";
	joynames[? 7] =  "Back (<)";
	joynames[? 8] =  "Start (>)";
	joynames[? 9] =  "Stick Button";
	joynames[? 10] =  "RS Button";

	for(i=11;i<20;i+=1)
	{
	    joynames[? i] =  "Joy Button "+string(i);
	}

	// GAMEPAD NAMES
	padnames[? gamepad_up] =  "Stick Up";
	padnames[? gamepad_down] =  "Stick Down";
	padnames[? gamepad_left] =  "Stick Left";
	padnames[? gamepad_right] =  "Stick Right";
	padnames[? gp_padu] =  "D-Pad Up";
	padnames[? gp_padd] =  "D-Pad Down";
	padnames[? gp_padl] =  "D-Pad Left";
	padnames[? gp_padr] =  "D-Pad Right";
	padnames[? gp_shoulderrb] =  "R Trigger";
	padnames[? gp_shoulderlb] =  "L Trigger";
	padnames[? gamepad_stick] =  "Stick Button";

	padnames[? gp_face1] =  "(A)";
	padnames[? gp_face2] =  "(B)";
	padnames[? gp_face3] =  "(X)";
	padnames[? gp_face4] =  "(Y)";
	padnames[? gp_shoulderl] =  "L Bumper";
	padnames[? gp_shoulderr] =  "R Bumper";
	padnames[? gp_select] =  "Back (<)";
	padnames[? gp_start] =  "Start (>)";
	padnames[? gp_stickl] =  "LStick Button";
	padnames[? gp_stickr] =  "RStick Button";
    
    // CONTROL SETS

    i=0;
    control_set_names = ds_list_create();
    control_set_names[| i++] = "CPU";
    control_set_names[| i++] = "Keyboard 1";
    control_set_names[| i++] = "Keyboard 2";
    control_set_names[| i++] = "Joystick 1";
    control_set_names[| i++] = "Joystick 2";
    control_set_names[| i++] = "Gamepad";
    //control_set_names[| i++] = "Nothing";

    i=0;
    control_set_order = ds_list_create();
    control_set_order[| i++] = gamepad;
    control_set_order[| i++] = cpu_control_set;
    control_set_order[| i++] = keyboard1;
    control_set_order[| i++] = keyboard2;


    // GUI CONTROLS
    gui_controls = ds_grid_create(stepmode+1, released+1);
	
	for(i=right; i<=down; i+=1) // directions
	{
	    for(ii=free; ii<=released; ii+=1) // free to released
	    {
	        init_val = (ii==free);
	        gui_controls[# i,ii] = init_val;
	    }
	}

	for(i=confirm; i<=stepmode; i+=1) // commands
	{
	    for(ii=free; ii<=released; ii+=1) // free to released
	    {
	        init_val = (ii==free);
	        gui_controls[# i,ii] = init_val;
	    }
	}
}