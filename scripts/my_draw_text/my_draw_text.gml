/// @param {Real} x
/// @param {Real} y
/// @param {String} text
/// @param {Bool} apply_fix default = true, move the text down by quarter of font size
function my_draw_text(x, y, text, apply_fix = true) {
    var yfix = 0;

    if (apply_fix) {
        var font_size = font_get_size(singleton_obj.current_font);
        yfix = ceil(font_size / singleton_obj.font_vmargin_coef);
    }

    draw_text(x, y + yfix, text);
}
