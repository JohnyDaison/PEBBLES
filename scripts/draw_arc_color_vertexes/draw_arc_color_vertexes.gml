function draw_arc_color_vertexes(center_x, center_y, radius, arc_start, arc_length, step_size, center_color, outer_color) {
    var steps = arc_length/step_size;

    for(var i = 0; i < steps; i++)
    {
        draw_set_color(outer_color);
        draw_vertex(center_x + lengthdir_x(radius, arc_start + i * step_size), center_y + lengthdir_y(radius, arc_start + i * step_size));
    
        draw_set_color(center_color);
        draw_vertex(center_x, center_y);
    
        draw_set_color(outer_color);
        draw_vertex(center_x + lengthdir_x(radius, arc_start + (i+1) * step_size), center_y + lengthdir_y(radius, arc_start + (i+1) * step_size));
    }
}
