if (ready && instance_exists(my_guy)) {
    // DRAW FIRST BACKGROUNDS (which serve as borders for health bars)
    if (draw_own_hp) {
        draw_set_alpha(hide_hp_alpha);
        draw_set_colour(bg_color);
        draw_rectangle(bg_x0, y0, bg_xhp, bar_y2, false);
    }
    
    if (hide_basehp_alpha > 0 && base_exists) {
        draw_set_alpha(hide_basehp_alpha);
        draw_rectangle(bg_x0, bar_y2 - border_width, bg_x1, y1, false);
    }

    
    // DRAW BAR BACKGROUNDS
    if (draw_own_hp) {
        draw_set_alpha(hide_hp_alpha);
        draw_set_colour(bar_bg_color);
        draw_rectangle(hp_x0, bar_y0, hp_x0 + handicapped_width - 1, bar_y1, false);
    }
    
    if (hide_basehp_alpha > 0 && base_exists) {
        draw_set_alpha(hide_basehp_alpha);
        draw_rectangle(basehp_x0, bar_y2, basehp_x0 + width - 1, bar_y3, false);
    }
    
    
    if (draw_own_hp) {
        // DRAW HEALTH
        if (hp_bar_width > 0 && hide_hp_alpha > 0) {
            draw_set_alpha(hide_hp_alpha);
            draw_set_colour(hp_bar_color);
            draw_rectangle(hp_x0, bar_y0, hp_x1, bar_y1, false);
        
            //part_type_color1(pt, merge_color(bar_color,c_white,0.33));
            part_emitter_region(system, em, hp_x0 + particle_size / 2, hp_x1 - particle_size / 2 - particle_distance, bar_y0 + particle_size / 2, bar_y1 - particle_size / 2, ps_shape_rectangle, ps_distr_linear);
            part_emitter_burst(system, em, pt, hp_bar_width / 50);
            part_system_drawit(system);
        }
    
        // DRAW HEALTH LOSS
        if (loss_width > 0 && healthloss_fade_ratio > 0 && hide_hp_alpha > 0) {
            draw_set_alpha(hide_hp_alpha * (0.5 * sqrt(healthloss_fade_ratio) + 0.66 * abs((singleton_obj.step_count mod (2 * healthloss_blink_time)) / healthloss_blink_time - 1)));
            draw_set_color(healthloss_color);

            draw_rectangle(loss_x0, bar_y0, loss_x1, bar_y1, false);
        }
    
        // DRAW HEALTH GAIN
        if (gain_width > 0 && healthgain_fade_ratio > 0 && hide_hp_alpha > 0) {
            draw_set_alpha(hide_hp_alpha * (0.5 * sqrt(healthgain_fade_ratio) + 0.66 * abs((singleton_obj.step_count mod (2 * healthgain_blink_time)) / healthgain_blink_time - 1)));
            draw_set_color(healthgain_color);

            draw_rectangle(gain_x0, bar_y0, gain_x1, bar_y1, false);
        }
    }

    if (base_exists) {
        // DRAW BASE HEALTH
        if (basehp_bar_width > 0) {
            draw_set_alpha(hide_basehp_alpha);
            draw_set_colour(basehp_bar_color);
            draw_rectangle(basehp_x0, bar_y2, basehp_x1, bar_y3, false);
        }
        
        // DRAW BASE HEALTH LOSS
        if (baseloss_width > 0 && basehealthloss_fade_ratio > 0 && hide_basehp_alpha > 0) {
            draw_set_alpha(hide_basehp_alpha * (0.5 * sqrt(basehealthloss_fade_ratio) + 0.66 * abs((singleton_obj.step_count mod (2 * healthloss_blink_time)) / healthloss_blink_time - 1)));
            draw_set_color(basehealthloss_color);

            draw_rectangle(baseloss_x0, bar_y2, baseloss_x1, bar_y3, false);
        }
        
        // DRAW BASE HEALTH GAIN
        if (basegain_width > 0 && basehealthgain_fade_ratio > 0 && hide_basehp_alpha > 0) {
            draw_set_alpha(hide_basehp_alpha * (0.5 * sqrt(basehealthgain_fade_ratio) + 0.66 * abs((singleton_obj.step_count mod (2 * healthgain_blink_time)) / healthgain_blink_time - 1)));
            draw_set_color(basehealthgain_color);

            draw_rectangle(basegain_x0, bar_y2, basegain_x1, bar_y3, false);
        }
    }
    
    // DRAW SCORE BACKGROUND
    draw_set_alpha(1);
    my_draw_set_font(score_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var score_str = string(score_value);
    var score_half_width = (floor(string_width(score_str)/2)+4)*scorepulse_scale;
    var score_border_dist = score_half_width+2*scorepulse_scale;
    var score_y = center_y + 18*(scorepulse_scale-scorepulse_normal);
    
    draw_set_color(c_white);
    draw_roundrect(center_x-1-score_border_dist, score_y-18*scorepulse_scale, center_x-1+score_border_dist, score_y+16*scorepulse_scale, false);
    draw_set_color(c_black);
    draw_roundrect(center_x-1-score_half_width, score_y-16*scorepulse_scale, center_x-1+score_half_width, score_y+14*scorepulse_scale, false);
    
    // DRAW SCORE
    draw_set_color(label_color);
    my_draw_text_transformed(center_x, score_y, score_str, scorepulse_scale, scorepulse_scale, 0);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
