/// @description gui_dropdown_script([state])
/// @function gui_dropdown_script
/// @param [state]
function gui_dropdown_script() {
	var state = "toggle";
	if(argument_count > 0)
	{
	    state = argument[0];
	}

	if(object_index == gui_button)
	{
	    if(gui_parent.list_picker.visible)
	        gui_hide_element(gui_parent.list_picker);
	    else
	    {
	        with(gui_dropdown)
	        {
	            if(list_picker.visible)
	                gui_hide_element(list_picker);
	        }
	        gui_show_element(gui_parent.list_picker);
	    }
	}
	if(object_index == gui_command_input)
	{
	    if(list_picker.visible || state == "hide")
	    {
	        gui_hide_element(list_picker);
	    }
	    else if(!list_picker.visible || state == "show")
	    {
	        gui_show_element(list_picker);
	    }
	}
	if(object_index == gui_scroll_list)
	{
	    if(gui_parent.visible)
	        gui_hide_element(gui_parent);
	}



}
