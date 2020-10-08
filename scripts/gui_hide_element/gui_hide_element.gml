/// @description gui_hide_element(element, [child_depth])
/// @function gui_hide_element
/// @param element
/// @param  [child_depth]
function gui_hide_element() {
	var element = argument[0];
	var child_depth = 0;
	if(argument_count > 1)
	{
	    child_depth = argument[1];
	}

	var count, i;

	with(element)
	{
	    visible = false;
	    if(child_depth == 0)
	    {
	        hidden = true;
	    }
    
	    count = ds_list_size(gui_content);
	    for(i = 0; i < count; i++)
	    {
	        gui_hide_element(gui_content[| i], child_depth + 1);
	    }
	}



}
