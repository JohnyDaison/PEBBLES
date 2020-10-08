var x1 = x - width / 2;
var y1 = y - height / 2;
var x2 = x1 + width - 1;
var y2 = y1 + height - 1;

draw_set_alpha(1);        
draw_set_colour(c_ltgray);
draw_rectangle(x1 - border_width, y1 - border_width, x2 + border_width, y2 + border_width, false);
draw_set_colour(c_black);
draw_rectangle(x1, y1, x2, y2, false);

if(instance_exists(camera))
{
    if(surface_exists(camera.surface))
    {
        draw_surface_stretched(camera.surface, x1, y1, width, height);
    }
}

event_inherited();