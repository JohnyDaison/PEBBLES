/// @description draw_light_arc(size, tint, arc_start, arc_length)
/// @function draw_light_arc
/// @param size
/// @param tint
/// @param arc_start
/// @param arc_length
function draw_light_arc() {

	var size = argument[0];
	var tint = argument[1];
	var arc_start = argument[2];
	var arc_length = argument[3];

	var step_size = 360 / DB.circle_precision;
	var _xx = x + light_xoffset, _yy = y + light_yoffset;
	var _steps = arc_length/step_size, _radius = size * radius;

	draw_primitive_begin(pr_trianglefan);

	draw_set_color(tint);
	draw_vertex(_xx, _yy);
	draw_set_color(c_black);
	for(var i = 0; i <= _steps; i++)
	{
	    draw_vertex(_xx + lengthdir_x(_radius, arc_start + i * step_size), _yy + lengthdir_y(_radius, arc_start + i * step_size));
	}
    
	draw_primitive_end();



}
