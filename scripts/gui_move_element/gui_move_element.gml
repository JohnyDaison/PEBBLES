/// @description gui_move_element(element, x, y, [child_depth])
/// @function gui_move_element
/// @param element
/// @param x
/// @param y
/// @param [child_depth]
function gui_move_element() {

	var element = argument[0];
	var new_x = argument[1];
	var new_y = argument[2];
	var child_depth = 0;
	if(argument_count > 3)
	{
	    child_depth = argument[3];
	}

	var count, i, x_diff, y_diff, child;

	with(element)
	{
	    x_diff = new_x - x;
	    y_diff = new_y - y;
    
	    x += x_diff;
	    y += y_diff;

	    rel_x = x - parent_frame.x;
	    rel_y = y - parent_frame.y;
    
	    count = ds_list_size(gui_content);
	    for(i = 0; i < count; i++)
	    {
	        child = gui_content[| i];
	        gui_move_element(child, child.x + x_diff, child.y + y_diff, child_depth + 1);
	    }
	}


}
