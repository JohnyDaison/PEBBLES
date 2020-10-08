/// @description draw_rectangle_color_vertexes(x1, y1, x2, y2, col1, col2, col3, col4);
/// @function draw_rectangle_color_vertexes
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param col1
/// @param col2
/// @param col3
/// @param col4
function draw_rectangle_color_vertexes() {

	var x1 = argument[0];
	var y1 = argument[1];
	var x2 = argument[2];
	var y2 = argument[3];
	var col1 = argument[4];
	var col2 = argument[5];
	var col3 = argument[6];
	var col4 = argument[7];


	// 1
	draw_set_color(col1);
	draw_vertex(x1, y1);

	draw_set_color(col2);
	draw_vertex(x2, y1);

	draw_set_color(col3);
	draw_vertex(x2, y2);

	// 2
	draw_set_color(col3);
	draw_vertex(x2, y2);

	draw_set_color(col4);
	draw_vertex(x1, y2);

	draw_set_color(col1);
	draw_vertex(x1, y1);


}
