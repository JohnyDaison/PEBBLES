if(!centered)
{
    var x_diff = -width/2;
    var y_diff = -height/2;
    x += x_diff;
    y += y_diff;
    
    if(rel_position == "relative")
    {
        rel_x += x_diff;
        rel_y += y_diff;
    }
    centered = true;
}

// BG
draw_set_alpha(bg_alpha);
if(self.draw_bg_color)
{
    draw_set_color(self.bg_color);
    draw_roundrect_ext(x,y, x+self.width,y+self.height, corner_radius, corner_radius, false);
}

// SCROLL BAR
if(self.drawn_bar_width > 0)
{
    draw_set_alpha(bg_alpha);
    draw_set_colour(bar_bg_color);
    
    draw_roundrect_ext(x + bar_start, y, 
                       x + bar_start + drawn_bar_width, y + self.height,
                       bar_corner_radius, bar_corner_radius, false);
    
    if (scroll_range > 0) {
        draw_set_alpha(bar_knob_alpha);
        draw_set_colour(bar_knob_color);
    
        draw_roundrect_ext(x + bar_start + bar_knob_margin, y + knob_offset + bar_knob_margin,
                           x + bar_start + drawn_bar_width - bar_knob_margin, y + knob_offset + knob_height - bar_knob_margin,
                           bar_corner_radius - bar_knob_margin, bar_corner_radius - bar_knob_margin, false);
    }
}

// BORDER
if(self.draw_border)
{
    draw_set_color(self.border_color);
    draw_set_alpha(self.border_alpha);
    draw_roundrect_ext(x,y, x + self.width, y + self.height, corner_radius, corner_radius, true);
}
