if(active)
{
    if(random(15) < 1) {
        
        draw_set_alpha(0.8);
        draw_set_color(color);
        var dist = (random(0.5) + 0.5) * lightning_range;
        var dir = random(360);
        var x_offset = lengthdir_x(dist, dir);
        var y_offset = lengthdir_y(dist, dir);
        draw_lightning_width(x, y, x + x_offset, y + y_offset, 
                            lightning_width, lightning_steps, lightning_thickness);
    }
}