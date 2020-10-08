/// @description create_text_popup(text, color, source, [x, y, offset])
/// @function create_text_popup
/// @param text
/// @param color
/// @param source
/// @param [x]
/// @param [y]
/// @param [offset]
function create_text_popup() {
	var text = argument[0];
	var color = argument[1];
	var source = argument[2];

	var xx = source.x;
	var yy = source.y;
	var offset = false;

	if(source.obj_center_offset)
	{
	    xx += lengthdir_x(source.obj_center_dist, source.obj_center_angle + source.image_angle);
	    yy += lengthdir_y(source.obj_center_dist, source.obj_center_angle + source.image_angle);
	}

	if(argument_count > 5)
	{
	    offset = argument[5];
	}

	if(argument_count > 3)
	{
	    if(offset)
	    {
	        xx += argument[3];
	    }
	    else
	    {
	        xx = argument[3];   
	    }
	}

	if(argument_count > 4)
	{
	    if(offset)
	    {
	        yy += argument[4];
	    }
	    else
	    {
	        yy = argument[4];   
	    }
	}


	var i = instance_create(xx, yy, text_popup_obj);
	i.str = text;
	i.my_color = color;
	i.tint_updated = false;
	i.source = source;

	return i;



}
