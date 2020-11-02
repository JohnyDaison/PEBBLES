event_inherited();

var xx = x + margin;
var yy = y + heading_height;

var col_shift = 0, row_shift = 0;

// column headings and backgrounds
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
                   col_x + column_width/2 - 1, yy + table_height, false);
    
    
    draw_set_alpha(0.5);
    draw_set_color(color_value);
    //draw_set_color(c_ltgray - color_value);
    draw_rectangle(col_x - (base_halfsize + 1), yy + row_height/2 - (base_halfsize + 1), 
                   col_x + base_halfsize, yy + row_height/2 + base_halfsize, false);
    
    draw_set_alpha(0.1);
    //draw_set_color(color_value);
    draw_rectangle(col_x - base_halfsize, yy + row_height/2 - base_halfsize, 
                   col_x + base_halfsize - 1, yy + row_height/2 + base_halfsize - 1, false);
                   
    if(ds_list_find_index(gaps_after, color) != -1) {
        col_shift += gap_size;
    }
}

draw_set_alpha(1);

// row labels and values
for(var row = g_black; row <= g_white; row += 1)
{
    var rcolor = row;
    if(row == 3) rcolor = g_blue;
    if(row == 4) rcolor = g_yellow;
    var rcolor_value = DB.colormap[? rcolor];
    var row_y = yy + (row + 1.5) * row_height + row_shift;
    var col_x = xx + column_width/2;
    
    draw_set_alpha(0.5);
    draw_set_color(rcolor_value);
    //draw_set_color(c_ltgray - rcolor_value);
    draw_rectangle(col_x - (base_halfsize + 1), row_y - (base_halfsize + 1), 
                   col_x + base_halfsize, row_y + base_halfsize, false);
    
    //draw_set_color(rcolor_value);
    draw_rectangle(col_x - base_halfsize, row_y - base_halfsize, 
                   col_x + base_halfsize - 1, row_y + base_halfsize - 1, false);
    
    
    col_shift = 0;
    for(col = g_black; col <= g_white; col+=1)
    {
        color = col;
        if(col == 3) color = g_blue;
        if(col == 4) color = g_yellow;        
        var ratio = get_power_ratio(rcolor, color);
        var halfsize = floor(ratio * base_halfsize);
        var col_x = xx + (col + 1.5) * column_width + col_shift;
        
        draw_set_alpha(0.5);
        //draw_set_color(c_ltgray - rcolor_value);
        draw_rectangle(col_x - (halfsize + 1), row_y - (halfsize + 1), 
                       col_x + halfsize, row_y + halfsize, false);
    
        //draw_set_color(rcolor_value);
        draw_rectangle(col_x - halfsize, row_y - halfsize, 
                       col_x + halfsize - 1, row_y + halfsize - 1, false);
                       
        if(ds_list_find_index(gaps_after, color) != -1) {
            col_shift += gap_size;
        }
    }
    
    if(ds_list_find_index(gaps_after, rcolor) != -1) {
        row_shift += gap_size;
    }
}    

