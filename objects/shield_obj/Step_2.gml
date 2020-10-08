///@description: SIZE UPDATE, GLITCHING, IMPACTS, PARTICLES

if(instance_exists(my_guy))
{
    if(my_guy != id && object_is_ancestor(my_guy.object_index, guy_obj))
    {
        x = my_guy.x;
        y = my_guy.y;
    }
    
    size = max(max_charge, charge);
    alpha = min(1,0.15+(charge/max_charge)*0.85);
    if(my_guy == id)
    {
        alpha = min(1,1-((charge-max_charge)/(collapse_threshold-max_charge))*0.9)
    }
    
    // glitching effect
    low_charge = (max_charge+overcharge) * low_charge_ratio;
    
    if(my_guy != id && charge < low_charge)
    {
        var since_start = singleton_obj.step_count - glitch_start;
        var since_end = singleton_obj.step_count - glitch_end;
        var charge_ratio = (charge/low_charge);
        var temp_min = lerp(glitch_min, glitch_max, 0.5*charge_ratio);
        var temp_max = lerp(glitch_min, glitch_max, 0.5 + 0.5*charge_ratio);
        
        if(since_end > glitch_delay && !glitching)
        {
            
            glitch_start = singleton_obj.step_count;
            glitch_alpha = 0.2 + 0.8*charge_ratio;
            glitching = true;
            glitch_delay = floor(random_range(temp_min, temp_max));
        }
        else if(since_start > glitch_length && glitching)
        {
            glitch_end = singleton_obj.step_count;
            glitch_alpha = 1;
            glitching = false;
            glitch_length = floor(random_range(temp_min, temp_max));
        }
    }
    else
    {
        glitch_alpha = 1;
        glitching = false;
    }
    
    // update size
    image_xscale = size*size_coef;
    image_yscale = size*size_coef;
    
    radius = base_radius*size*size_coef;
    field_focus = radius*field_ratio;
    
    // IMPACT
    if(impact_draw)
    {
        var last_index = impact_image_index;
        impact_image_index += impact_anim_speed;
        
        if(last_index == impact_anim_length)
        {
            impact_image_index = 0;
        }
        
        if(floor(last_index) != floor(impact_image_index))
        {
            for(i = impact_anim_length-1;i>0;i-=1)
            {
                var tint = ds_map_find_value(impact_tints, i-1);
                var dir = ds_map_find_value(impact_directions, i-1);
                ds_map_replace(impact_tints, i, tint);
                ds_map_replace(impact_directions, i, dir);
            }
            
            if(impact_newtint != -1 && impact_newdir != -1)
            {
                ds_map_replace(impact_tints,0,impact_newtint);
                ds_map_replace(impact_directions,0,impact_newdir);
                impact_newtint = -1;
                impact_newdir = -1;
                impact_image_index = 0;
            }
            else
            {
                ds_map_replace(impact_tints,0,-1);
                ds_map_replace(impact_directions,0,-1);
            }
        }
        
        if(impact_image_index > impact_anim_length)
        {
            impact_image_index = impact_anim_length;
            impact_draw = false;
        }
    }
    
    // PARTICLES
    part_emitter_region(system,em,x - radius,x + radius,y - radius,y + radius,ps_shape_ellipse,ps_distr_linear);
}
else
{
    instance_destroy();
    exit;
}

event_inherited();