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
    draw_roundrect(x,y,x+self.width,y+self.height,false);
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
    if(!is_list_picker)
    {
        if(first_item > 0)
        {
            //my_draw_text(x+self.main_width/2, y+2, string_hash_to_newline("..."));
            draw_sprite_ext(centered_arrow_spr, 0,
                            x+self.main_width/2, y + ends_height/2 + 3, 1,-1, 0, c_white, 1);
        }
        if(last_item < item_count-1)
        {
            //my_draw_text(x+self.main_width/2, y + ends_height + 2 + max_items*item_height, string_hash_to_newline("..."));
            draw_sprite_ext(centered_arrow_spr, 0,
                            x+self.main_width/2, y + 1.5*ends_height - 2 + max_items*item_height, 1,1, 0, c_white, 1);
        }
    }
    
    
    show_count = last_item - first_item + 1;
    var cur, high, force_bg, base_color, over_color, final_text_color;
    
    for(i = 0;i < show_count; i+=1)
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
                
                    draw_roundrect(x, y + ends_height + i*item_height + item_padding/2,
                               x+self.main_width, y + ends_height + (i+1)*item_height - item_padding/2,false);
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
                my_draw_text(x+self.main_width/2, y + ends_height + (i+0.5)*item_height, items[| first_item+i]);
            }
            else if(align_items == "left")
            {
                my_draw_text(x+4, y + ends_height + (i+0.5)*item_height, items[| first_item+i]);   
            }
        }
        else if(type == "icon")
        {
            if(align_items == "center")
            {
                draw_sprite_ext(items[| first_item+i], 0, x+self.main_width/2, y + ends_height + (i+0.5)*item_height, 1, 1, 0, self.color, 1);
            }
            else if(align_items == "left")
            {
                draw_sprite_ext(items[| first_item+i], 0, x+4, y + ends_height + (i+0.5)*item_height, 1, 1, 0, self.color, 1);   
            }   
        }
    }
}

// SCROLL BAR
if(self.bar_width > 0)
{
    draw_set_alpha(bg_alpha);
    draw_set_colour(bar_bg_color);
    
    draw_roundrect(x + bar_start, y, x + bar_start + bar_width, y + self.height, false);
    
    draw_set_alpha(bar_knob_alpha);
    draw_set_colour(bar_knob_color);
    
    draw_roundrect(x + bar_start + bar_knob_margin, y + knob_offset + bar_knob_margin,
                   x + bar_start + bar_width - bar_knob_margin, y + knob_offset + knob_height - bar_knob_margin, false);
}

// BORDER
if(self.draw_border)
{
    draw_set_color(self.border_color);
    draw_set_alpha(self.border_alpha);
    draw_roundrect(x,y, x + self.width, y + self.height, true)
}                                                    

