draw_set_color(c_blue);

draw_line_dashed(x,y,x+width,y,8,2);
draw_line_dashed(x,y,x,y+height,8,2);
draw_line_dashed(x,y+height,x+width,y+height,8,2);
draw_line_dashed(x+width,y,x+width,y+height,8,2);

