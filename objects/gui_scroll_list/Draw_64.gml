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

// ALIGN
draw_set_color(self.color);
my_draw_set_font(self.font);
if(align_items == "center")
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
}
else if(align_items == "left")
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
}

// DEPRESSED
if(depressed == true)
{
    depressed_offset = depressed_dir;
    image_index = 1;
}
else
{
    depressed_offset = 0;
    image_index = 0;
}

// ITEMS
if(cur_item != -1)
{ 
    var items_start_x = x + side_margin;
    var items_center_x = items_start_x + self.drawn_main_width/2;
    var items_start_y = y + ends_height;
    
    var show_count = last_item - first_item + 1;
    var cur, high, force_bg, base_color, over_color, final_text_color;
    
    for(var i = 0; i < show_count; i++)
    {
        // ITEM BG
        cur = (first_item+i == cur_item);
        high = (first_item+i == highlighted_item);
        force_bg = false;
        over_color = -1;

        if(alternate_lines)
        {
            draw_set_alpha(0.1);
        
            if((first_item+i) mod 2 == 0)
            {
                base_color = c_white;
            }
            else
            {
                base_color = c_black;
            }
        }
        else
        {
            base_color = item_bg_color;
            draw_set_alpha(item_bg_alpha);
        }
        
        
        final_text_color = text_color;
        
        if(high || cur)
        {
            if(alternate_lines)
            {
                draw_set_alpha(0.5);
            }
            force_bg = true;
        }
        
        if(high)
        {
            over_color = highlight_color;
            final_text_color = highlight_text_color;
        }
        if(cur)
        {            
            over_color = select_color;
            final_text_color = select_text_color;
        }
        

        if(self.draw_lines_bg || force_bg)
        {
            draw_set_colour(base_color);
    
            var reps, max_reps = 2;
            for(reps = 0; reps<max_reps; reps++)
            {
                if(reps == 0 || (reps == 1 && over_color > 0))
                {
                    if(reps == 1)
                    {
                        draw_set_colour(over_color);
                    }
                
                    draw_roundrect_ext(items_start_x, items_start_y + i*item_height + item_padding/2,
                                       items_start_x + self.drawn_main_width, items_start_y + (i+1)*item_height - item_padding/2,
                                       corner_radius, corner_radius, false);
                }
            }
        }
        
        
        // ITEM CONTENT
        draw_set_alpha(1);
        
        if(type == "text")
        {
            draw_set_color(final_text_color);
            if(align_items == "center")
            {
                my_draw_text(items_center_x, items_start_y + (i+0.5) * item_height, items[| first_item+i]);
            }
            else if(align_items == "left")
            {
                my_draw_text(items_start_x + content_padding, items_start_y + (i+0.5) * item_height, items[| first_item+i]);
            }
        }
        else if(type == "icon")
        {
            if(align_items == "center")
            {
                draw_sprite_ext(items[| first_item+i], 0, items_center_x, items_start_y + (i+0.5) * item_height, 1, 1, 0, self.color, 1);
            }
            else if(align_items == "left")
            {
                draw_sprite_ext(items[| first_item+i], 0, items_start_x + content_padding, items_start_y + (i+0.5) * item_height, 1, 1, 0, self.color, 1);
            }
        }
    }
}

// SCROLL BAR
if(self.drawn_bar_width > 0)
{
    draw_set_alpha(bg_alpha);
    draw_set_colour(bar_bg_color);
    
    draw_roundrect_ext(x + bar_start, y, 
                       x + bar_start + drawn_bar_width, y + self.height,
                       bar_corner_radius, bar_corner_radius, false);
    
    draw_set_alpha(bar_knob_alpha);
    draw_set_colour(bar_knob_color);
    
    draw_roundrect_ext(x + bar_start + bar_knob_margin, y + knob_offset + bar_knob_margin,
                       x + bar_start + drawn_bar_width - bar_knob_margin, y + knob_offset + knob_height - bar_knob_margin,
                       bar_corner_radius - bar_knob_margin, bar_corner_radius - bar_knob_margin, false);
}

// BORDER
if(self.draw_border)
{
    draw_set_color(self.border_color);
    draw_set_alpha(self.border_alpha);
    draw_roundrect_ext(x,y, x + self.width, y + self.height, corner_radius, corner_radius, true);
}
