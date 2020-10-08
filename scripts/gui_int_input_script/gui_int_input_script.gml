function gui_int_input_script() {
	var dial, dial_dir;

	dial_dir = gui_parent.cur_sign;
	if(dial_dir == 0)
	{
	    dial_dir = 1;
	}

	dial = gui_parent.dial;

	if(button_function == "sign_switch")
	{
	    gui_parent.cur_sign *= -1;
	}
    
	if(button_function == "up")
	{
	    if(gui_parent.value < gui_parent.max_value)
	    {
	        dial.value += dial_dir * dial.value_step;
	    }
    
	}
	if(button_function == "down")
	{
	    if(gui_parent.value > gui_parent.min_value)
	    {
	        dial.value -= dial_dir * dial.value_step;
	    }
	}
	if(button_function == "up" || button_function == "down")
	{
	    if(dial.value < 0)
	    {
	        dial.value = abs(dial.value);
	        gui_parent.cur_sign = -dial_dir;    
	    }
	}


	/*
	if(button_function == "plus")
	{
	    gui_parent.cur_sign = 1;
	}
	if(button_function == "minus")
	{
	    gui_parent.cur_sign = -1;
	}
	*/



}
