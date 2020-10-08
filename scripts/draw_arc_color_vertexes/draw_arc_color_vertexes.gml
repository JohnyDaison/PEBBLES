/// @description draw_arc_color_vertexes(x, y, radius, start_angle, arc_length, step_size, center_color, outer_color);
/// @function draw_arc_color_vertexes
/// @param x
/// @param y
/// @param radius
/// @param start_angle
/// @param arc_length
/// @param step_size
/// @param center_color
/// @param outer_color
function draw_arc_color_vertexes() {

	var center_x = argument[0];
	var center_y = argument[1];
	var radius = argument[2];
	var arc_start = argument[3];
	var arc_length = argument[4];
	var step_size = argument[5];
	var center_color = argument[6];
	var outer_color = argument[7];

	var steps = arc_length/step_size;

	for(var i = 0; i < steps; i++)
	{
	    draw_set_color(outer_color);
	    draw_vertex(center_x + lengthdir_x(radius, arc_start + i * step_size), center_y + lengthdir_y(radius, arc_start + i * step_size));
    
	    draw_set_color(center_color);
	    draw_vertex(center_x, center_y);
    
	    draw_set_color(outer_color);
	    draw_vertex(center_x + lengthdir_x(radius, arc_start + (i+1) * step_size), center_y + lengthdir_y(radius, arc_start + (i+1) * step_size));
	}



}
