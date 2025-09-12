event_inherited();

/// UPDATE VALUES AND COORDS
if (ready && instance_exists(my_guy)) {
    width = view_get_wport( my_camera.view ) - 2*border_width - my_camera.border_width * 2;
    base_exists = instance_exists(my_guy.my_base) && my_guy.my_base.object_index == guy_spawner_obj;
    
    // HIDING OWN HP
    if (hide_own_hp) {
        hide_own_hp = (my_guy.damage == my_guy.min_damage);
    }
    
    if (hide_own_hp) {
        if (hide_hp_alpha > 0) {
            hide_hp_alpha = max(0, hide_hp_alpha - hide_speed);
        }
    }
    else {
        if (hide_hp_alpha < 1) {
            hide_hp_alpha = min(1, hide_hp_alpha + hide_speed);
        }
    }
    
    // BLINK OWN HP
    if (own_hp_blink_time > 0) {
        draw_own_hp = ((own_hp_blink_time div own_hp_blink_rate) + 1) mod 2;
    
        own_hp_blink_time--;
    }

    
    // HIDING BASE HP
    if (base_exists) {
        hide_base_hp = (my_guy.my_base.damage == 0);
        
        if (hide_base_hp) {
            if (hide_basehp_alpha > 0) {
                hide_basehp_alpha = max(0, hide_basehp_alpha - hide_speed);
            }
        }
        else {
            if (hide_basehp_alpha < 1) {
                hide_basehp_alpha = min(1, hide_basehp_alpha + hide_speed);
            }
        }
    }
    
    // HP
    hp_ratio = max(0,1 - my_guy.damage/my_guy.normal_hp);
    //hp_bar_color = DB.colormap[? my_guy.my_color]; //merge_colour(low_tint, high_tint, hp_ratio);
    hp_bar_width = width*hp_ratio;
    
    //bg_color = c_white - my_camera.body_color;
    
    if(base_exists)
    {
        basehp_ratio = max(0,1 - my_guy.my_base.damage/my_guy.my_base.hp);
        //basehp_bar_color = DB.colormap[? my_guy.my_color]; //merge_colour(low_tint, high_tint, hp_ratio);
        basehp_bar_width = width*basehp_ratio;
    }
           
    min_damage = my_guy.min_damage;
    handicapped_width = width*max(0,1 - my_guy.min_damage/my_guy.normal_hp)
    
    // DETECTION

    // HP LOSS
    if(health_last_value > hp_ratio)
    {
        healthloss_fade_ratio = 1;
    }
    loss_width = width*(healthloss_last_value - hp_ratio);
    
    // HP GAIN
    if(health_last_value < hp_ratio)
    {
        healthgain_fade_ratio = 1;
    }
    gain_width = width*(hp_ratio - healthgain_last_value);

    // BASE HP LOSS
    if(base_exists)
    {
        if(basehealth_last_value > basehp_ratio)
        {
            basehealthloss_fade_ratio = 1;
        }

        baseloss_width = width*(basehealthloss_last_value - basehp_ratio);
        
        // BASE HP GAIN
        if(basehealth_last_value < basehp_ratio)
        {
            basehealthgain_fade_ratio = 1;
        }
        basegain_width = width*(basehp_ratio - basehealthgain_last_value);
    }    
    
    // FADING
    
    // LOSS FADING
    if(healthloss_fade_ratio == 0)
    {
        healthloss_last_value = hp_ratio;
    }
    else
    {
        //healthloss_color = my_guy.last_damage_tint;
        healthloss_fade_ratio = max(0, healthloss_fade_ratio - healthloss_fade_speed);
    }
    
    // GAIN FADING
    if(healthgain_fade_ratio == 0)
    {
        healthgain_last_value = hp_ratio;
    }
    else
    {
        //healthgain_color = my_guy.last_damage_tint;
        healthgain_fade_ratio = max(0, healthgain_fade_ratio - healthgain_fade_speed);
    }
    
    health_last_value = hp_ratio;
    
    
    // BASE HP LOSS FADING
    if(base_exists)
    {
        if(basehealthloss_fade_ratio == 0)
        {
            basehealthloss_last_value = basehp_ratio;
        }
        else
        {
            basehealthloss_fade_ratio = max(0, basehealthloss_fade_ratio - basehealthloss_fade_speed);
        }
        
        // BASE GAIN FADING
        if(basehealthgain_fade_ratio == 0)
        {
            basehealthgain_last_value = basehp_ratio;
        }
        else
        {
            basehealthgain_fade_ratio = max(0, basehealthgain_fade_ratio - basehealthgain_fade_speed);
        }
        
        basehealth_last_value = basehp_ratio;
    }

    // SCORE
    last_score_value = score_value;
    score_value = my_player.stats[? "score"];
    
    // CHANGE
    if(last_stable_score_value != score_value)
    {
        // CHANGE IMPULSE
        if(scorepulse_speed == 0 || last_score_value != score_value)
        {
            if(scorepulse_speed == 0)
            {
                scorepulse_speed = scorepulse_grow_speed;
            }
            else if(scorepulse_speed > 0)
            {
                scorepulse_scale = scorepulse_normal;
            }
            else if(scorepulse_speed < 0)
            {
                scorepulse_scale = scorepulse_max;
            }
        }
        
        // STEP
        scorepulse_scale += scorepulse_speed;
        
        // LIMITS
        if(scorepulse_scale >= scorepulse_max)
        {
            scorepulse_speed = -scorepulse_shrink_speed;
            scorepulse_scale = scorepulse_max;
        }
        
        if(scorepulse_scale <= scorepulse_normal && scorepulse_speed < 0)
        {
            scorepulse_speed = 0;
            scorepulse_scale = scorepulse_normal;
            last_stable_score_value = score_value;
        }
    }
    // STABLE
    else
    {
        scorepulse_speed = 0;
        scorepulse_scale = scorepulse_normal;
    }

    // UPDATE COORDINATES
    
    // POSITIONS
    x = my_camera.border_width + self.view_x_offset -1;
    y = my_camera.border_width + self.view_y_offset -1;
    
    offset_x = x;
    offset_y = y;

    // VERTICAL
    y0 = y;
    y1 = y+height-1;
    
    bar_y0 = y + border_width; 
    bar_y1 = y + guy_height - border_width -2;
    bar_y2 = y + guy_height -1;
    bar_y3 = y + height - border_width -1;
    
    // HORIZONTAL
    hp_x0 = x + border_width; 
    hp_x1 = hp_x0 + hp_bar_width -1;
    
    if(base_exists)
    {
        basehp_x0 = x + border_width; 
        basehp_x1 = basehp_x0 + basehp_bar_width -1;
    }
    
    // BG
    bg_x0 = x;
    //bg_x1 = hp_x1 + border_width -1;
    bg_xhp = x + handicapped_width + 2*border_width -1;
    bg_x1 = x + width + 2*border_width -1;
    
    center_x = x + border_width + width/2 -1;
    center_y = y + height/2 -1;
    
    // LOSS GAIN
    loss_x0 = hp_x1 + 1;
    loss_x1 = loss_x0 + loss_width - 1;
    
    gain_x0 = hp_x1 - gain_width;
    gain_x1 = hp_x1;
    
    if(base_exists)
    {
        baseloss_x0 = basehp_x1 + 1;
        baseloss_x1 = baseloss_x0 + baseloss_width - 1;
        
        basegain_x0 = basehp_x1 - basegain_width;
        basegain_x1 = basehp_x1;
    }
}

