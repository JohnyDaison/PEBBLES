event_inherited();

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
my_draw_set_font(label_font);

var xx = self.x + 32;
var yy = self.y + 32;

// column headings
for (var col = g_dark; col <= g_octarine; col += 1) {
    var color = col;
    if (col == 3) color = g_blue;
    if (col == 4) color = g_yellow;
    var col_str = string(color);
    var color_value = DB.colormap[? color];
    var col_x = xx + (col + 1) * 48;

    // TODO: rewrite this line
    draw_set_color(c_ltgray - color_value);
    my_draw_text(col_x + 1, yy + 1, col_str);

    draw_set_color(color_value);
    my_draw_text(col_x, yy, col_str);


    draw_set_alpha(1);
    draw_rectangle(col_x, yy - 48, col_x + 32, yy - 16, false);
    draw_set_alpha(self.alpha * self.focus_modifier);
}

// row labels and values
for (var row = g_dark; row <= g_octarine; row += 1) {
    var rcolor = row;
    if (row == 3) rcolor = g_blue;
    if (row == 4) rcolor = g_yellow;
    var row_str = string(rcolor);
    var rcolor_value = DB.colormap[? rcolor];

    // TODO: rewrite this line and DRY the whole block
    draw_set_color(c_ltgray - rcolor_value);

    my_draw_text(xx + 1, yy + (row + 1) * 32 + 1, row_str);
    for (var col = g_dark; col <= g_octarine; col += 1) {
        var color = col;
        if (col == 3) color = g_blue;
        if (col == 4) color = g_yellow;
            
        var ratioStr = string(round(get_power_ratio(rcolor, color) * 100));
        my_draw_text(xx + (col + 1) * 48 + 1, yy + (row + 1) * 32 + 1, ratioStr);
    }

    draw_set_color(rcolor_value);

    my_draw_text(xx, yy + (row + 1) * 32, row_str);
    for (var col = g_dark; col <= g_octarine; col += 1) {
        var color = col;
        if (col == 3) color = g_blue;
        if (col == 4) color = g_yellow;
            
        var ratioStr = string(round(get_power_ratio(rcolor, color) * 100));
        my_draw_text(xx + (col + 1) * 48, yy + (row + 1) * 32, ratioStr);
    }
}
