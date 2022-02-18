function draw_light_arc(size, tint, camera, arc_start, arc_length) {
    var step_size = 360 / DB.circle_precision;
    var _xx = x + light_xoffset + camera.light_x_offset, _yy = y + light_yoffset + camera.light_y_offset;
    var _steps = arc_length/step_size, _radius = size * radius * camera.light_size_coef;

    draw_primitive_begin(pr_trianglefan);

    draw_set_color(tint);
    draw_vertex(_xx, _yy);
    draw_set_color(c_black);
    for(var i = 0; i <= _steps; i++)
    {
        draw_vertex(_xx + lengthdir_x(_radius, arc_start + i * step_size), _yy + lengthdir_y(_radius, arc_start + i * step_size));
    }
    
    draw_primitive_end();
}
