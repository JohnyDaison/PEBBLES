/// @description gui_show_element(element, [child_depth])
/// @function gui_show_element
/// @param element
/// @param  [child_depth]
function gui_show_element() {
	var element = argument[0];
	var child_depth = 0;
	if(argument_count > 1)
	{
	    child_depth = argument[1];
	}

	var count, i;

	with(element)
	{
	    visible = true;
	    if(child_depth == 0)
	    {
	        hidden = false;
	    }
    
	    count = ds_list_size(gui_content);
	    for(i = 0; i < count; i++)
	    {
	        if(!gui_content[| i].hidden)
	        {
	            gui_show_element(gui_content[| i], child_depth + 1);
	        }
	    }
	}



}
