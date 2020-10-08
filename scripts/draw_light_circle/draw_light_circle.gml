/// @description draw_light_circle(size, tint)
/// @function draw_light_circle
/// @param size
/// @param tint
function draw_light_circle() {

	var size = argument[0];
	var tint = argument[1];

	draw_circle_colour(x+light_xoffset, y+light_yoffset, size*radius, tint, c_black, false);

	//draw_light_arc(size, tint, 0, 360);


}
