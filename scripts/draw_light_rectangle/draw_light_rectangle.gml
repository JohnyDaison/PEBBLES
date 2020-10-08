/// @description draw_light_rectangle(size, tint, [base_size])
/// @function draw_light_rectangle
/// @param size
/// @param tint
function draw_light_rectangle() {

	var size = argument[0];
	var tint = argument[1];
	var base_size = size;
	var is_ambient = false;

	if(argument_count > 2)
	{
	    base_size = argument[2];
	    is_ambient = true;
	}


	if(size == 0)
	{
	    return false;   
	}

	if(base_size == 0)
	{
	    base_size = min(other.rectangle_base_size, size);   
	}

	if(size < base_size)
	{
	    size = base_size;   
	}


	var corner_radius = max(1, size) * self.corner_radius;
	var base_corner_radius = max(1, base_size) * self.corner_radius;

	/*
	var corner_radius = size * self.corner_radius;
	var base_corner_radius = base_size * self.corner_radius;
	*/
	var center_x = x + light_xoffset, center_y = y + light_yoffset;

	var bbox_width = bbox_right - bbox_left;
	var bbox_height = bbox_bottom - bbox_top;

	var base_half_width = base_size * bbox_width / 2;
	var base_half_height = base_size * bbox_height / 2;

	var half_width = size * bbox_width / 2;
	var half_height = size * bbox_height / 2;

	/*
	my_console_log("LIGHT RECTANGLE START");
	my_console_log("size: " + string(size) + " base_size: " + string(base_size));

	my_console_log("base: " + string(base_corner_radius) + " orig_corner: " + string(corner_radius));
	my_console_log("base_half_width: " + string(base_half_width) + " base_half_height: " + string(base_half_height));
	my_console_log("half_width: " + string(half_width) + " half_height: " + string(half_height));
	*/


	// base radius
	if(base_corner_radius > base_half_width)
	{
	    base_corner_radius = base_half_width;
	}

	if(base_corner_radius > base_half_height)
	{
	    base_corner_radius = base_half_height;
	}

	// corner radius
	if(is_ambient)
	{
	    var hor_dist = half_width - (base_half_width - base_corner_radius);
	    var vert_dist = half_height - (base_half_height - base_corner_radius);
	    corner_radius = min(hor_dist, vert_dist);
	    //my_console_log("AMBIENT");
	}
	else
	{
	    corner_radius *= 2;
	    //my_console_log("DIRECT");
	}

	//my_console_log("base: " + string(base_corner_radius) + " corner: " + string(corner_radius));

	// corner radius
	if(corner_radius > half_width)
	{
	    corner_radius = half_width;
	}

	if(corner_radius > half_height)
	{
	    corner_radius = half_height;
	}

	// total radius
	var total_radius = corner_radius;

	//my_console_log("base: " + string(base_corner_radius) + " total: " + string(total_radius));


	// base
	var left_x      = center_x - base_half_width;
	var right_x     = center_x + base_half_width;
	var top_y       = center_y - base_half_height;
	var bottom_y    = center_y + base_half_height;

	// base
	if(left_x > center_x)
	{
	    left_x = center_x;   
	}

	if(right_x < center_x)
	{
	    right_x = center_x;   
	}

	if(top_y > center_y)
	{
	    top_y = center_y;   
	}

	if(bottom_y < center_y)
	{
	    bottom_y = center_y;   
	}

	// inner
	var inner_left_x    = left_x    + base_corner_radius;
	var inner_right_x   = right_x   - base_corner_radius;
	var inner_top_y     = top_y     + base_corner_radius;
	var inner_bottom_y  = bottom_y  - base_corner_radius;

	// inner
	if(inner_left_x > center_x)
	{
	    inner_left_x = center_x;   
	}

	if(inner_right_x < center_x)
	{
	    inner_right_x = center_x;   
	}

	if(inner_top_y > center_y)
	{
	    inner_top_y = center_y;   
	}

	if(inner_bottom_y < center_y)
	{
	    inner_bottom_y = center_y;   
	}

	// outer
	var outer_left_x    = inner_left_x    - total_radius;
	var outer_right_x   = inner_right_x   + total_radius;
	var outer_top_y     = inner_top_y     - total_radius;
	var outer_bottom_y  = inner_bottom_y  + total_radius;

	// outer
	if(outer_left_x > inner_left_x)
	{
	    outer_left_x = inner_left_x;   
	}

	if(outer_right_x < inner_right_x)
	{
	    outer_right_x = inner_right_x;   
	}

	if(outer_top_y > inner_top_y)
	{
	    outer_top_y = inner_top_y;   
	}

	if(outer_bottom_y < inner_bottom_y)
	{
	    outer_bottom_y = inner_bottom_y;   
	}


	draw_primitive_begin(pr_trianglelist);


	// central rectangle

	draw_set_color(tint);

	draw_rectangle_color_vertexes(inner_left_x, inner_top_y, inner_right_x, inner_bottom_y, tint, tint, tint, tint);


	// cardinal rectangles

	draw_rectangle_color_vertexes(inner_left_x, outer_top_y, inner_right_x, inner_top_y, c_black, c_black, tint, tint);

	draw_rectangle_color_vertexes(inner_right_x, inner_top_y, outer_right_x, inner_bottom_y, tint, c_black, c_black, tint);

	draw_rectangle_color_vertexes(inner_left_x, inner_bottom_y, inner_right_x, outer_bottom_y, tint, tint, c_black, c_black);

	draw_rectangle_color_vertexes(outer_left_x, inner_top_y, inner_left_x, inner_bottom_y, c_black, tint, tint, c_black);


	// arcs

	var arc_length = 90;
	var step_size = 360 / DB.circle_precision;

	draw_arc_color_vertexes(inner_left_x, inner_top_y, total_radius, 90, arc_length, step_size, tint, c_black);

	draw_arc_color_vertexes(inner_right_x, inner_top_y, total_radius, 0, arc_length, step_size, tint, c_black);

	draw_arc_color_vertexes(inner_right_x, inner_bottom_y, total_radius, 270, arc_length, step_size, tint, c_black);

	draw_arc_color_vertexes(inner_left_x, inner_bottom_y, total_radius, 180, arc_length, step_size, tint, c_black);


	draw_primitive_end();

	//my_console_log("LIGHT RECTANGLE END");

	return true;


}
