if(ready || shrink_anim_phase > 0)
{
    /*
    draw_set_alpha(0.2);
    gpu_set_blendmode(bm_add);
    draw_circle_colour(x, y, shrink_anim_phase*radius, bg_anim_color, bg_color, false);
    gpu_set_blendmode(bm_normal);
    */

    var bg_col1 = merge_color(bg_color, bg_anim_color,
                    max(0, 1 - abs(bg_anim_phase - bg_col1_phase)) * bg_anim_alpha);
    var bg_col2 = merge_color(bg_color, bg_anim_color,
                    max(0, 1 - abs(bg_anim_phase - bg_col2_phase)) * bg_anim_alpha);

    draw_set_alpha(0.4);
    draw_rectangle_color( lerp(x, bbox_left, shrink_anim_phase), lerp(y, bbox_top, shrink_anim_phase),
                          lerp(x, bbox_right, shrink_anim_phase), lerp(y, bbox_bottom, shrink_anim_phase),
                          bg_col1, bg_col1, bg_col2, bg_col2, false);
}

if(ready && active && shrink_anim_phase == 1)
{
    // STEPS
    if(anim_set_steps_total > 1 && anim_set_current_step > 0) {
        var max_bar_width = (bbox_right - bbox_left) - 2 * step_indicator_margin;
        var total_separators_width = step_indicator_margin * (anim_set_steps_total - 1);
        var step_width = ceil((max_bar_width - total_separators_width)/anim_set_steps_total);
        var bar_start_x = floor(bbox_left + step_indicator_margin);
        var bar_start_y = floor(bbox_bottom - (step_indicator_margin + step_indicator_height - 1));
    
        draw_set_alpha(step_indicator_alpha);
        
        for(var step_i = 0; step_i < anim_set_steps_total; step_i++) {
            if(step_i < anim_set_current_step) {
                draw_set_colour(step_light_color);
            } else {
                draw_set_colour(step_dark_color);
            }
            
            var step_start_x = bar_start_x + step_i * (step_width + step_indicator_margin);
            
            draw_rectangle(step_start_x, bar_start_y, 
                           step_start_x + step_width - 1, bar_start_y + step_indicator_height - 1, false);
        }
    }
    
    // IMAGES
    if(sprite_exists(bg_sprite))
    {
        draw_sprite_ext(bg_sprite, sprite_step, x+bg_sprite_xx, y+bg_sprite_yy, anim_scale, anim_scale, anim_angle, bg_tint, anim_fade_ratio);
    }
    if(sprite_exists(sprite))
    {
        draw_sprite_ext(sprite, sprite_step, x+sprite_xx, y+sprite_yy, anim_scale, anim_scale, anim_angle, main_tint, anim_fade_ratio);
    }
    if(sprite_exists(fg_sprite))
    {
        draw_sprite_ext(fg_sprite, sprite_step, x+sprite_xx, y+sprite_yy, anim_scale, anim_scale, anim_angle, fg_tint, anim_fade_ratio);
    }
    
    // LABELS
    draw_set_alpha(1);
    draw_set_colour(c_white);
    my_draw_set_font(infodisplay_font);
    draw_set_halign(fa_center);
    
    if(heading_label != "")
    {
        draw_set_valign(fa_bottom);
        my_draw_text_transformed(x + bg_sprite_xx, bbox_top - 4 + bg_sprite_yy, heading_label, 1, 1, 0); //anim_scale
    }
    
    if(main_label != "")
    {
        if(single_text_mode)
        {
            draw_set_valign(fa_middle);
        }
        else
        {
            draw_set_valign(fa_bottom);
        }
        my_draw_text_transformed(x+bg_sprite_xx, y+bg_sprite_yy+label_offset*anim_scale, main_label, 1, 1, 0); //anim_scale
    }
    if(sub_label != "")
    {
        draw_set_valign(fa_top);
        my_draw_text_transformed(x+bg_sprite_xx, y+bg_sprite_yy+sublabel_offset*anim_scale, sub_label, 1, 1, 0); //anim_scale
    }
}

event_inherited();
