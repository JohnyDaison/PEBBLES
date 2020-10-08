if(!custom_sprite)
{
    var cur_y = y-step-hover_offset;
    var final_tint = tint;
    
    if(armed)
    {
        if(armed_blink_phase > 0)
        {
            final_tint = merge_colour(tint, c_white, armed_blink_phase*armed_blink_ratio);
        }
        else if(armed_blink_phase < 0)
        {
            final_tint = merge_colour(tint, c_black, -armed_blink_phase*armed_blink_ratio);
        }
    }
    
    draw_sprite_ext(sprite_index,image_index, x, cur_y, 1,1,image_angle, final_tint, fade_counter*image_alpha*self.holo_alpha);
    
    if(stack_size > 1)
    {
        final_x = x + radius;
        final_y = cur_y + radius;
        str = string(stack_size);
        
        my_draw_set_font(stack_font);
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_set_alpha(fade_counter*image_alpha);
    
        draw_set_color(c_black);
        my_draw_text(final_x-2, final_y-2, string_hash_to_newline(str));
        draw_set_color(c_white);
        my_draw_text(final_x, final_y, string_hash_to_newline(str));
        
        draw_set_alpha(1);
    }
}

event_inherited();
