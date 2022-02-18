function draw_light_circle(size, tint, camera) {
    draw_circle_colour(x + light_xoffset + camera.light_x_offset, 
                       y + light_yoffset + camera.light_y_offset,
                       size * radius * camera.light_size_coef, tint, c_black, false);
}
