if (!active) {
    exit;
}

var cursor, category;

with(cursor_obj) {
    cursor = self;
}

x = cursor.x;
y = cursor.y;

clear_categories();

category = get_category("Game");

ds_list_clear(results);
var result_count = collision_point_list(cursor.room_x, cursor.room_y, game_obj, false, false, results, false);

for (var result_index = 0; result_index < result_count; result_index++) {
    var new_line = self.generate_result_line(results[| result_index]);
    ds_list_add(category.lines, new_line);
}

category = get_category("Non-Game");

ds_list_clear(results);
var result_count = collision_point_list(cursor.room_x, cursor.room_y, non_game_obj, false, false, results, false);

for (var result_index = 0; result_index < result_count; result_index++) {
    var new_line = self.generate_result_line(results[| result_index]);
    ds_list_add(category.lines, new_line);
}

category = get_category("GUI");

with(gui_object) {
    if (x <= cursor.x && cursor.x < x + width && y <= cursor.y && cursor.y < y + height) {
        var new_line = other.generate_result_line(self);
        ds_list_add(category.lines, new_line);
    }
}

var whole_str = categories_to_string();

my_draw_set_font(font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var rect_width = string_width_ext(whole_str, line_separation, max_width);
var rect_height = string_height_ext(whole_str, line_separation, max_width);

var left_x, top_y, right_x, bottom_y;

left_x = x + x_offset;
top_y = y + y_offset;
right_x = left_x + rect_width;
bottom_y = top_y + rect_height;

if (right_x > display_get_gui_width()) {
    right_x = x - x_offset;
    left_x = right_x - rect_width;
}

if (bottom_y > display_get_gui_height()) {
    bottom_y = y - y_offset;
    top_y = bottom_y - rect_height;
}

draw_set_color(c_black);
draw_set_alpha(bg_alpha);
draw_rectangle(left_x - margin, top_y - margin, right_x + margin, bottom_y + margin, false);

draw_set_color(c_white);
draw_set_alpha(1);
draw_text_ext(left_x, top_y, whole_str, line_separation, max_width);