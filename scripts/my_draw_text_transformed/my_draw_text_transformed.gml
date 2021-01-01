function my_draw_text_transformed(xx, yy, text, xscale, yscale, angle) {
	var font_size = font_get_size(singleton_obj.current_font);
	draw_text_transformed(xx, yy + ceil(font_size/singleton_obj.font_vmargin_coef), text, xscale, yscale, angle);
}
