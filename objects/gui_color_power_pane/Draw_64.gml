event_inherited();

var xx = self.x + self.margin;
var yy = self.y + self.heading_height;

var col_shift = 0, row_shift = 0;
var halfRow = self.row_height / 2;
var halfColumn = self.column_width / 2;


// column headings and backgrounds
col_shift = self.big_gap_size;
var row_y = yy + halfRow;

for (var col = 0; col < self.color_count; col += 1) {
    var color = self.color_order[| col];
    var color_value = DB.colormap[? color];
    var col_x = xx + (col + 1.5) * self.column_width + col_shift;

    draw_set_alpha(self.column_bg_alpha);
    draw_set_color(merge_color(color_value, c_white, self.column_white_ratio));
    draw_rectangle(col_x - halfColumn, yy,
                   col_x + halfColumn - 1, yy + self.row_height - 1, false);

    draw_sprite_ext(column_circle_spr, 0, col_x, row_y, 1, 1, 0, color_value, 1);

    if (ds_list_find_index(self.gaps_after, color) != -1) {
        col_shift += self.gap_size;
    }
}


// row arrows and values
row_shift += self.big_gap_size;

for (var row = 0; row < self.color_count; row += 1) {
    var rowColor = self.color_order[| row];
    var rowColorValue = DB.colormap[? rowColor];
    row_y = yy + (row + 1.5) * self.row_height + row_shift;
    var col_x = xx + halfColumn;

    draw_set_alpha(0.5);
    draw_set_color(c_dkgray);
    draw_rectangle(col_x - halfColumn, row_y - halfRow,
                   col_x + halfColumn - 1, row_y + halfRow - 1, false);

    draw_set_color(rowColorValue);
    draw_sprite_ext(row_arrow_spr, 0, col_x, row_y, 1, 1, 0, rowColorValue, 1);

    col_shift = self.big_gap_size;
    for (var col = 0; col < self.color_count; col += 1) {
        var color = self.color_order[| col];
        var color_value = DB.colormap[? color];
        var ratio = get_power_ratio(rowColor, color);
        var halfsize = floor(ratio * self.base_halfsize);
        col_x = xx + (col + 1.5) * self.column_width + col_shift;

        draw_set_alpha(self.column_bg_alpha);
        draw_set_color(merge_color(color_value, c_white, self.column_white_ratio));
        draw_rectangle(col_x - halfColumn, row_y - halfRow,
                       col_x + halfColumn - 1, row_y + halfRow - 1, false);

        if (rowColor != g_dark) {
            if (ratio > 0) {
                draw_set_color(rowColorValue);
                draw_set_alpha(0.5);
                //draw_set_color(c_ltgray - rowColorValue);
                draw_rectangle(col_x - (halfsize + 1), row_y - (halfsize + 1),
                               col_x + halfsize, row_y + halfsize, false);

                //draw_set_color(rowColorValue);
                draw_set_alpha(1);
                draw_rectangle(col_x - halfsize, row_y - halfsize,
                               col_x + halfsize - 1, row_y + halfsize - 1, false);
            } else {
                draw_set_alpha(1);
                draw_sprite_ext(heal_power_spr, 0, col_x, row_y, 1, 1, 0, rowColorValue, 1);
            }
        }

        if (ds_list_find_index(self.gaps_after, color) != -1) {
            col_shift += self.gap_size;
        }
    }

    if (ds_list_find_index(self.gaps_after, rowColor) != -1) {
        row_shift += self.gap_size;
    }
}
