if(split_done)
{
    var final_fade_ratio = min(1, fade_ratio*1.5);
    
    draw_set_alpha(final_fade_ratio * 0.9);
    draw_set_color(bg_color);
    
    draw_roundrect(x - floor(width/2), y - floor(height/2), x + floor(width/2), y + floor(height/2), false);
    
    draw_set_alpha(final_fade_ratio);
    my_draw_set_font(font);

    //var base_x_offset = -str_width/2;
    var base_x_offset = -max_line_width/2;
    //var max_x_offset = str_width/2;
    var max_x_offset = base_x_offset + max_line_width;
    
    //line_count = height div line_height;
    //var base_y_offset = -str_height/2 + line_height/2;
    var base_y_offset = -str_height/2 + line_height/2;

    var x_offset = base_x_offset;
    var y_offset = base_y_offset;
    
    //var y_offset = -str_height/2;
    
    // OLD APPROACH
    /*
    var base_y_offset = -str_height/2 + line_height/2;
    if(line_count < 2)
    {
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);

        var x_offset = base_x_offset;
    }
    else
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        var x_offset = 0;
    }
    draw_set_color(tint);
    
    my_draw_text_ext(x + x_offset, y, display_str, line_height, max_width);
    */
    
    
    // NEW APPROACH
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);

    var displayed_word_count = ds_list_size(display_word_list);
    var line_x_offset = base_x_offset;
    var line_index = 0;
    var last_line_index = -1;
    var prev_word_color = g_nothing;
    
    for(var word_index = 0; word_index < displayed_word_count; word_index++)
    {
        var word = display_word_list[| word_index];
        var full_word = word_list[| word_index];
        var word_width = string_width(word);
        var full_word_width = string_width(full_word);
        //var end_of_message = word_index == word_count - 1;
        var new_line = (x_offset + full_word_width) > max_x_offset;
        
        // NEW LINE
        if(new_line)
        {
            y_offset += line_height;
            line_index++;
            
            // INIT
            if(line_index + 1 > display_line_count)
            {
                display_line_count = line_index + 1;
                if(line_width[? line_index] > str_width)
                {
                    str_width = line_width[? line_index];
                }
                width = str_width + 2*hor_margin;
                image_xscale = width/128;
            }
        }
        
        // CARRIAGE RETURN
        if(last_line_index != line_index)
        {
            if(line_width[? line_index] > 0)
            {
                line_x_offset = -line_width[? line_index]/2;
            }
            else
            {
                line_x_offset = base_x_offset;
            }
            
            x_offset = line_x_offset;
        }
        
        // DECIDE COLOR
        var outline_tint = tint - c_gray;
        var word_tint = tint;
        var term_id = term_index_map[? word_index];
        var is_term = !is_undefined(term_id);
        var term_color = g_nothing;
        
        // TERMS
        if(is_term)
        {
            term_color = DB.term_color_map[? term_id];
            
            // COPY PREVIOUS TERM COLOR
            if(term_color == DB.default_highlight_color && prev_word_color != g_nothing)
            {
                term_color = prev_word_color;
            }
            
            // WORD TINT
            word_tint = DB.colormap[? term_color];
            if(term_color == g_octarine)
            {
                word_tint = singleton_obj.octarine_tint;
            }
            
            // OUTLINE TINT
            var outline_tint = word_tint - c_gray;
        }
        
        // DRAW THE WORD
        draw_set_color(outline_tint);
        my_draw_text(x-1 + x_offset, y-1 + y_offset, word, apply_my_text_fix);
        my_draw_text(x+1 + x_offset, y+1 + y_offset, word, apply_my_text_fix);
    
        draw_set_color(word_tint);
        my_draw_text(x + x_offset, y + y_offset, word, apply_my_text_fix);
        
        // NEXT WORD
        x_offset += word_width + word_spacing;
        
        prev_word_color = term_color;
        last_line_index = line_index;
    }

    draw_set_valign(fa_top);
}
