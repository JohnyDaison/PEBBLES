/// @param x
/// @param y
/// @param string
/// @param [apply_fix]=true
function my_draw_text() {

	var font_size = font_get_size(singleton_obj.current_font);
	var yfix = 0;
	if(argument_count == 3 || argument[3])
	{
	    yfix = ceil(font_size/singleton_obj.font_vmargin_coef);
	}
	draw_text(argument[0], argument[1] + yfix, argument[2]);


}
