/// @description draw_lightning_width(x1,y1, x2,y2, width, steps, thickness)
/// @function draw_lightning_width
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param width
/// @param steps
/// @param thickness
function draw_lightning_width(x1,y1, x2,y2, width, steps, thickness) {
	var xdiff = x2 - x1;
	var ydiff = y2 - y1;
	var lgt_r1 = -0.5*width; 
	var lgt_r2 = 0.5*width;

	var temp_x1,temp_y1,temp_x2,temp_y2;
	temp_x1 = x1;
	temp_y1 = y1;

	for(var i = 1; i<=steps; i++)
	{
	    temp_x2 = x1 + xdiff*(i/steps) + random_range(lgt_r1, lgt_r2); 
	    temp_y2 = y1 + ydiff*(i/steps) + random_range(lgt_r1, lgt_r2);
	    if(i==steps)
	    {
	        temp_x2 = x2;
	        temp_y2 = y2;
	    }
	    draw_line_width(temp_x1,temp_y1,temp_x2,temp_y2,thickness);
	    temp_x1 = temp_x2;
	    temp_y1 = temp_y2;
	}
}
