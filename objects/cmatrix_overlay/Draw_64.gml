event_inherited();

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
my_draw_set_font(label_font);

var xx = x+32;
var yy = y+32;

// column headings
for(col = g_black; col <= g_octarine; col += 1)
{
    color = col;
    if(col == 3) color = g_blue;
    if(col == 4) color = g_yellow;
    col_str = string(color);
    color_value = DB.colormap[? color];
    col_x = xx+(col+1)*48;
    
    draw_set_color(c_ltgray - color_value);
    my_draw_text(col_x+1, yy+1, col_str);
    
    draw_set_color(color_value);
    my_draw_text(col_x, yy, col_str);
    
    
    draw_set_alpha(1);
    draw_rectangle(col_x, yy - 48, col_x + 32, yy - 16, false);
    draw_set_alpha(self.alpha*1*focus_modifier);
}

// row labels and values
for(row = g_black; row <= g_octarine; row += 1)
{
    rcolor = row;
    if(row == 3) rcolor = g_blue;
    if(row == 4) rcolor = g_yellow;
    row_str = string(rcolor);
    rcolor_value = DB.colormap[? rcolor];
    
    draw_set_color(c_ltgray - rcolor_value);
    
    my_draw_text(xx+1, yy+(row+1)*32+1, row_str);
    for(col=g_black; col<=g_octarine; col+=1)
    {
        color = col;
        if(col == 3) color = g_blue;
        if(col == 4) color = g_yellow;
        my_draw_text(xx+(col+1)*48+1, yy+(row+1)*32+1, string(round(get_power_ratio(rcolor,color)*100)));
    }
    
    draw_set_color(rcolor_value);
    
    my_draw_text(xx, yy+(row+1)*32, row_str);
    for(col=g_black; col<=g_octarine; col+=1)
    {
        color = col;
        if(col == 3) color = g_blue;
        if(col == 4) color = g_yellow;
        my_draw_text(xx+(col+1)*48, yy+(row+1)*32, string(round(get_power_ratio(rcolor,color)*100)));
    }    
}    

