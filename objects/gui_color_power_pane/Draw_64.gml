event_inherited();

var xx = x + margin;
var yy = y + heading_height;

var col_shift = 0, row_shift = 0;
var half_row = row_height/2;


// column headings and backgrounds
col_shift = big_gap_size;
row_y = yy + half_row;

for(var col = g_black; col <= g_white; col += 1)
{
    var color = col;
    if(col == 3) color = g_blue;
    if(col == 4) color = g_yellow;
    var color_value = DB.colormap[? color];
    var col_x = xx + (col + 1.5) * column_width + col_shift;
    
    draw_set_alpha(column_bg_alpha);
    draw_set_color(merge_color(color_value, c_white, column_white_ratio));
    draw_rectangle(col_x - column_width/2, yy,
                   col_x + column_width/2 - 1, yy + row_height - 1, false);

    draw_sprite_ext(column_circle_spr, 0, col_x, row_y, 1, 1, 0, color_value, 1);
                   
    if(ds_list_find_index(gaps_after, color) != -1) {
        col_shift += gap_size;
    }
}


// row arrows and values
row_shift += big_gap_size;

for(var row = g_black; row <= g_white; row += 1)
{
    var rcolor = row;
    if(row == 3) rcolor = g_blue;
    if(row == 4) rcolor = g_yellow;
    var rcolor_value = DB.colormap[? rcolor];
    var row_y = yy + (row + 1.5) * row_height + row_shift;
    var col_x = xx + column_width/2;
    
    draw_set_alpha(0.5);
    draw_set_color(c_dkgray);
    draw_rectangle(col_x - column_width/2, row_y - half_row,
                    col_x + column_width/2 - 1, row_y + half_row - 1, false);
    
    draw_set_color(rcolor_value);
    draw_sprite_ext(row_arrow_spr, 0, col_x, row_y, 1, 1, 0, rcolor_value, 1);
    
    col_shift = big_gap_size;
    for(col = g_black; col <= g_white; col+=1)
    {
        color = col;
        if(col == 3) color = g_blue;
        if(col == 4) color = g_yellow;
        var color_value = DB.colormap[? color];
        var ratio = get_power_ratio(rcolor, color);
        var halfsize = floor(ratio * base_halfsize);
        var col_x = xx + (col + 1.5) * column_width + col_shift;
        
        draw_set_alpha(column_bg_alpha);
        draw_set_color(merge_color(color_value, c_white, column_white_ratio));
        draw_rectangle(col_x - column_width/2, row_y - half_row,
                        col_x + column_width/2 - 1, row_y + half_row - 1, false);
        
        if(ratio > 0) {
            draw_set_color(rcolor_value);
            draw_set_alpha(0.5);
            //draw_set_color(c_ltgray - rcolor_value);
            draw_rectangle(col_x - (halfsize + 1), row_y - (halfsize + 1), 
                           col_x + halfsize, row_y + halfsize, false);
    
            //draw_set_color(rcolor_value);
            draw_set_alpha(1);
            draw_rectangle(col_x - halfsize, row_y - halfsize, 
                           col_x + halfsize - 1, row_y + halfsize - 1, false);
        } else {
            draw_set_alpha(1);
            draw_sprite_ext(heal_power_spr, 0, col_x, row_y, 1, 1, 0, rcolor_value, 1);
        }
        
        
        if(ds_list_find_index(gaps_after, color) != -1) {
            col_shift += gap_size;
        }
    }
    
    if(ds_list_find_index(gaps_after, rcolor) != -1) {
        row_shift += gap_size;
    }
}    
