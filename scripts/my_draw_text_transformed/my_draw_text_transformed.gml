function my_draw_text_transformed(argument0, argument1, argument2, argument3, argument4, argument5) {
	var font_size = font_get_size(singleton_obj.current_font);
	draw_text_transformed(argument0, argument1 + ceil(font_size/singleton_obj.font_vmargin_coef), argument2, argument3, argument4, argument5);


}
