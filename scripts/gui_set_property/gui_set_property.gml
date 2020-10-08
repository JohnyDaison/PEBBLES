/// @description gui_set_property(gui_object, property, value, apply_to_contents)
/// @function gui_set_property
/// @param gui_object
/// @param  property
/// @param  value
/// @param  apply_to_contents
function gui_set_property(argument0, argument1, argument2, argument3) {
	var obj = argument0;
	var property = argument1;
	var value = argument2;
	var do_contents = argument3;

	var count, i, child;

	with(obj)
	{
	    if(property == "draw_bg_color")
	    {
	        draw_bg_color = value;
	    }
    
	    if(do_contents)
	    {
	        count = ds_list_size(gui_content);
        
	        for(i = 0; i < count; i++)
	        {
	            child = gui_content[| i];
            
	            gui_set_property(child, property, value, do_contents);
	        }
	    }
	}



}
