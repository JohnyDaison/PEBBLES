function draw_orb_belt_gui(belt_x, belt_y, list, orientation, belt_width, belt_size, camera) {
    var outer_border_width = 2;
    var inner_border_width = 2;
    var border_i;

    var orb, slot_x1, slot_x2, slot_y1, slot_y2, orb_x1, orb_x2, orb_y1, orb_y2, belt_x2, belt_y2,
        ii, edge_offset, selected, edge_range = belt_width/2-2;

    if(belt_size > 0 && ds_exists(list, ds_type_list))
    {
        draw_set_alpha(0.6);
        draw_set_colour(c_white);
        if(orientation == "vertical")
        {
            belt_x2 = belt_x + belt_width -1;
            belt_y2 = belt_y + belt_size * belt_width -1;
        }
        else if(orientation == "horizontal")
        {
            belt_x2 = belt_x + belt_size * belt_width -1;
            belt_y2 = belt_y + belt_width -1;
        }
    
        // background
        draw_rectangle(belt_x, belt_y, belt_x2, belt_y2, false);
   
        var orb_count = ds_list_size(list);
        for(ii=0; ii<belt_size; ii++)
        {
            if(orientation == "vertical")
            {
                slot_x1 = belt_x;
                slot_x2 = belt_x + belt_width -1;
                slot_y1 = belt_y + ii * belt_width;
                slot_y2 = belt_y + (ii+1) * belt_width -1;
            }
            else if(orientation == "horizontal")
            {
                slot_x1 = belt_x + ii * belt_width;
                slot_x2 = belt_x + (ii+1) * belt_width -1;
                slot_y1 = belt_y;
                slot_y2 = belt_y + belt_width -1;
            }
        
            slot_x1 = floor(slot_x1);
            slot_y1 = floor(slot_y1);
            slot_x2 = ceil(slot_x2);
            slot_y2 = ceil(slot_y2);
        
            orb_x1 = slot_x1 + inner_border_width;
            orb_y1 = slot_y1 + inner_border_width;
            orb_x2 = slot_x2 - inner_border_width;
            orb_y2 = slot_y2 - inner_border_width;
        
            //slot outline
            //draw_set_alpha(0.6);
            draw_set_alpha(1);
            //draw_set_colour(c_black);
            draw_set_colour(c_white);
        
            for(border_i = -outer_border_width; border_i < inner_border_width; border_i++)
            {
                draw_rectangle(slot_x1 + border_i, slot_y1 + border_i,
                                slot_x2 - border_i, slot_y2 - border_i, true);
            }
        
            // ORBS
            if(ii<orb_count)
            {
                orb = list[|ii];
                if(!instance_exists(orb))
                {
                    my_console_log("ORB in a BELT doesn't exist! " + string(orb));
                    continue;
                }
            
                var clamped_energy = min(1, orb.energy/orb.base_energy);
                var display_size = 0.2;
                
                if (clamped_energy > DB.orb_warning_threshold) {
                    display_size = 0.7 + 0.3 * ((clamped_energy - DB.orb_warning_threshold) / (1 - DB.orb_warning_threshold));
                } else if (clamped_energy > DB.orb_exhaustion_threshold) {
                    display_size = 0.2 + 0.5 * sqrt((clamped_energy - DB.orb_exhaustion_threshold) / (1 - DB.orb_exhaustion_threshold));
                }
                
                edge_offset = floor((1 - display_size) * edge_range);
            
                var blink_off = false,
                    blink_white = false,
                    size_coef = 0,
                    size_boost = 0,
                    orb_radius = 0;

                if(orb.newly_got_steps > 0)
                {
                    //blink_off = round(orb.newly_got_steps / orb.newly_got_anim_cycle) mod 2;
                    //blink_white = round(orb.newly_got_steps / orb.newly_got_anim_cycle) mod 2;
                    var anim_progress = /*sqr*/(1 - (orb.newly_got_steps / orb.newly_got_anim_duration));
                    size_coef = (1- ( abs(orb.newly_got_steps - orb.newly_got_anim_peak) / orb.newly_got_anim_peak));
                    size_boost = edge_range * orb.newly_got_anim_sizecoef * size_coef;
                    var view_center_x = __view_get( e__VW.XPort, camera.view ) + __view_get( e__VW.WPort, camera.view )/2;
                    var view_center_y = __view_get( e__VW.YPort, camera.view ) + __view_get( e__VW.HPort, camera.view )/2;
                    
                    orb_x1 = lerp(view_center_x, orb_x1, anim_progress);
                    orb_x2 = lerp(view_center_x, orb_x2, anim_progress);
                    orb_y1 = lerp(view_center_y, orb_y1, anim_progress);
                    orb_y2 = lerp(view_center_y, orb_y2, anim_progress);
                    
                    orb_radius = (1-anim_progress) * (abs((orb_x2 - orb_x1) - 2*edge_offset + 2*size_boost));
                }
            
                edge_offset -= size_boost;
            
                selected = false;
                if(orb.orbit_anchor == orb.my_guy && (orb.color_added || orb.color_held))
                {
                    selected = true;
                }
            
                if(!blink_off)
                {
                    if(orb.newly_got_steps > 0)
                    {
                        draw_set_alpha(0.6);
                    }
                    else
                    {
                        draw_set_alpha(1);
                    }
                
                    //base energy
                    draw_set_colour(merge_colour(c_black, orb.tint, 0.8 + 0.2*clamped_energy));
                    if(blink_white)
                    {
                        draw_set_colour(c_white);
                    }
                
                    if(orb.newly_got_steps > 0)
                    {
                        draw_roundrect_ext(orb_x1 + edge_offset, orb_y1 + edge_offset,
                                        orb_x2 - edge_offset, orb_y2 - edge_offset, orb_radius, orb_radius, false);
                    }
                    else
                    {
                        draw_rectangle(orb_x1 + edge_offset, orb_y1 + edge_offset,
                                        orb_x2 - edge_offset, orb_y2 - edge_offset, false);
                    }
                    
                    //outline
                    draw_set_colour(c_ltgray);
                    if(orb.newly_got_steps > 0)
                    {
                        draw_roundrect_ext(orb_x1 + edge_offset, orb_y1 + edge_offset,
                                        orb_x2 - edge_offset, orb_y2 - edge_offset, orb_radius, orb_radius, true);
                    }
                    else
                    {
                        draw_rectangle(orb_x1 + edge_offset, orb_y1 + edge_offset,
                                        orb_x2 - edge_offset, orb_y2 - edge_offset, true);
                    }
                
                    //extra energy
                    if(orb.energy > orb.base_energy)
                    {
                        edge_offset = floor((1 - min(1, (orb.energy-orb.base_energy) / (orb.max_energy-orb.base_energy)))*edge_range);
                    
                        draw_set_alpha(0.6);
                        draw_set_colour(c_white);
                        draw_rectangle(orb_x1 + edge_offset, orb_y1 + edge_offset,
                        orb_x2 - edge_offset, orb_y2 - edge_offset, false);
                    }
                }
            
                //selected
                if(selected)
                {
                    draw_set_alpha(0.8);
                    draw_set_colour(c_dkgray);
                    draw_rectangle(slot_x1, slot_y1, slot_x2, slot_y2, true);
                    draw_set_colour(c_black);
                    draw_rectangle(slot_x1 +1, slot_y1 +1, slot_x2 -1, slot_y2 -1, true);
                    draw_rectangle(slot_x1 +2, slot_y1 +2, slot_x2 -2, slot_y2 -2, true);
                    draw_set_colour(c_dkgray);
                    draw_rectangle(slot_x1 +3, slot_y1 +3, slot_x2 -3, slot_y2 -3, true);
                }
    
                //draw_set_colour(c_white);
                //my_draw_text(slot_x, orb_panel_y + (ii+1) * -belt_width, string(orb.id % 100))
            }
        }
    }
}
