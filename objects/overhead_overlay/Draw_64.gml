/// @description UPDATE, DRAW

var screen_side = 0;  // LEFT -1, CENTER 0, RIGHT 1
var belt_order = right_side_belt_order;
var belt_count = ds_list_size(belt_order);
var col;

// UPDATE
if(instance_exists(my_guy))
{  
    my_camera = my_guy.my_player.my_camera;
    
    if(gamemode_obj.player_count > 1)
    {
        screen_side = my_guy.my_player.number mod 2;
        if(screen_side == 1)
        {
            screen_side = -1;   
        }
        else
        {
            screen_side = 1;
        }
        
        if(screen_side == -1)
        {
            belt_order = left_side_belt_order;
        }
    }
    
    if(main_camera_obj.on)
    {
        my_camera = main_camera_obj.id;
    }
    
    if(instance_exists(my_camera))
    {
        // GUY POSITION
        x = (my_guy.x - __view_get( e__VW.XView, my_camera.view ))*my_camera.zoom_level + __view_get( e__VW.XPort, my_camera.view );
        
        guy_y = (my_guy.y - __view_get( e__VW.YView, my_camera.view ))*my_camera.zoom_level + __view_get( e__VW.YPort, my_camera.view );
        name_offset = guy_y - my_camera.zoom_level*name_dist;
        //y = name_offset - dial_dist;
        y = __view_get( e__VW.HPort, my_camera.view )*0.25;
       
        status_x = __view_get( e__VW.XPort, my_camera.view );
        
        // ABI HINT POSITION 
        if(my_guy.control_method == cpu_control || my_guy.control_method == keyboard)
        {
            abi_y2 = my_camera.border_width + 244 + __view_get( e__VW.YPort, my_camera.view );
            abi_x = __view_get( e__VW.XPort, my_camera.view ) + 80;
            if(gamemode_obj.no_inventory)
            {
                abi_y2 -= 84;
                abi_x += 16;
            }
        }
        if(my_guy.control_method == joystick || my_guy.control_method == gamepad)
        {
            abi_y2 = my_camera.border_width + 112 + __view_get( e__VW.YPort, my_camera.view );
            abi_x = __view_get( e__VW.XPort, my_camera.view ) + 280;
            if(gamemode_obj.no_inventory)
            {
                abi_x -= 184;
            }
        }
        
        abi_y1 = abi_y2 - dial_dist;
        
        // ABI PANEL
        abi_panel_x = __view_get( e__VW.WPort, my_guy.my_player.my_camera.view )*0.5 + __view_get( e__VW.XPort, my_guy.my_player.my_camera.view ) - abi_panel_width/2;
        abi_panel_y = __view_get( e__VW.YPort, my_camera.view ) + __view_get( e__VW.HPort, my_camera.view ) - my_camera.border_width;
        status_panel_y = abi_panel_y;
        
        
        // CORRECTION FOR 1-VIEW MODE        
        if(my_camera == main_camera_obj.id)
        {
            abi_x += __view_get( e__VW.XPort, my_guy.my_player.my_camera.view );
        }
        
        // ABILITY DISPLAY
        
        last_abi_status = abi_status;
        
        // ABI COLOR
        //show_debug_message("> " + my_guy.potential_abi_name + " " + string(my_guy.slots_triggered));
        if(my_guy.potential_abi_name != "" || my_guy.slots_triggered)
        {
            abi_color = my_guy.potential_color;
        }
        else
        {
            if(my_guy.channeling)
            {
                abi_color = g_black;    
            }
            else
            {
                abi_color = my_guy.my_color;
            }
        }
        
        if(my_guy.ready_to_die)
        {    
            abi_color = -1;
        }
        
        var abi_name = DB.abi_name_map[? abi_color];
        var abi_key = DB.abimap[? abi_color];
        if(is_undefined(abi_key) || !mod_get_state("abilities") || !has_level(my_guy, abi_key, 1))
        {
            abi_name = "";
            hide_abi = true;
        }
        else
        {
            abi_icon = DB.abi_icons[? abi_color];
            abi_tint = DB.colormap[? abi_color];
            abi_label_tint = c_white;
            hide_abi = false;
        
            // COOLDOWN
            
            if(abi_color < g_black || my_guy.abi_cooldown_length[? abi_color] <= 0)
            {
                abi_left = 0;
            }
            else
            {
                abi_left = my_guy.abi_cooldown[? abi_color] / my_guy.abi_cooldown_length[? abi_color];
            }
            
            if(abi_left > 0)
            {
                abi_status = -12*abi_left;
                abi_dial_ratio = 1 - 2*abi_left;
                abi_dial_ratio = clamp(abi_dial_ratio,-1,1);
                abi_dial_color = make_color_rgb((max(abi_dial_ratio,0)-1)*-255,(min(abi_dial_ratio,0)+1)*255,0);
                abi_dial_color = merge_color(abi_dial_color,c_white,0.5);
                //abi_dial_color = make_color_rgb(clamp(abi_dial_ratio,-1,0)*-255,clamp(abi_dial_ratio,0,1)*255,0);
                //abi_dial_color = merge_color(green_color,red_color,my_guy.abi_cooldown/my_guy.abi_cooldown_length);
                
                if(abs(round(abi_status)) > 0)
                {
                    abi_name_fade = abi_name_maxfade;
                }
            }
            else
            {
                abi_status = 0;
            }
        }

        
        if(abi_name != last_abi_name)
        {
            abi_name_fade = abi_name_maxfade;
        }
        last_abi_name = abi_name;
        
        my_draw_set_font(abi_font);
        label_height = string_height(abi_name) + 4;
        label_width = string_width(abi_name) + 4;
        
        // SLOTS DISPLAY
    
        slots_y = abi_y2 + dial_dist + 8;

        full_slot_number = my_guy.slots_absorbed;
        slot_color = my_guy.my_color;

        ready_slot_number = my_guy.slot_number;
        max_slot_number = my_guy.slot_maxnumber;
            
        slot_offset = -slot_size*max_slot_number/2;
        slot_tint = ds_map_find_value(DB.colormap,slot_color);
        
        // ORB BELTS
        if(screen_side == -1)
        {
            orb_panel_x = __view_get( e__VW.XPort, my_guy.my_player.my_camera.view ) + my_camera.border_width - 1 + orb_border_width;
        }
        else if(screen_side == 0 || screen_side == 1)
        {
            orb_panel_x = __view_get( e__VW.XPort, my_guy.my_player.my_camera.view ) + __view_get( e__VW.WPort, my_guy.my_player.my_camera.view )  - my_camera.border_width - orb_panel_width - orb_border_width;
        }
        orb_panel_y = __view_get( e__VW.YPort, my_camera.view ) + __view_get( e__VW.HPort, my_camera.view ) - my_camera.border_width - orb_border_width;
        
        belt_size = 0;
        for(i=0;i<belt_count;i++)
        {
            col = belt_order[| i]
            {
                if(show_belt[? col])
                {
                    belt_size = max(belt_size, my_guy.belt_size[? col]);
                }    
            }
            col++;
        }
        orb_panel_height = belt_size*orb_belt_width;

        // MOVE LOCK
        move_lock_y = guy_y + my_camera.zoom_level*(name_dist + 32);
    }
}

/// DRAW
if(instance_exists(my_guy) && instance_exists(my_camera))
{
    my_draw_set_font(abi_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // ABILITY HINT DISPLAY
    if(!hide_abi && (!my_guy.lost_control || my_guy.ready_to_die))
    {
        // ABILITY NAME
        var abi_half_width = floor(label_width/2) +4;
        var abi_half_height = floor(label_height/2) +2;
        draw_set_color(abi_tint);   
        draw_set_alpha(0.5 * min(1,abi_name_fade));   
        draw_roundrect(abi_x - abi_half_width, abi_y1 - abi_half_height,
                        abi_x + abi_half_width, abi_y1 + abi_half_height, false);
        
        draw_set_color(abi_label_tint);
        draw_set_alpha(1 * min(1,abi_name_fade));
        my_draw_text(abi_x, abi_y1 ,string_hash_to_newline(abi_name));
        
        // BG    
        draw_sprite_ext(bg_sprite,0,abi_x,abi_y2,1,1,0,c_white,0.9*min(1,abi_name_fade));
        
        // COOLDOWN
        if(abi_status < 0)
        {
            // OUTER DIAL
            draw_sprite_ext(outer_dial_small_spr,abs(abi_status),abi_x+1,abi_y2,sign(abi_status),1,0,abi_dial_color,0.9);
        }
        
        // ICON
        draw_sprite_ext(abi_icon,0,abi_x,abi_y2,1,1,0,c_white,0.9*min(1,abi_name_fade*2)); // +((my_guy.facing-1)/-2)
    }
    
    // STATUS EFFECTS PANEL
    
    var ii, status_count, effect, panel_width, bar_height, status_color, status_tint, status_icon;
    var xx = x, active_count = 0;
    
    status_count = ds_map_size(status_order);
    for(i=1; i<=status_count; i++)
    {
        status_color = status_order[? i];
        effect = DB.color_effects[? status_color];

        if(my_guy.status_left[? effect.codename] > 0)
        {
            active_count += 1;
        }
    }
    panel_width = active_count*(status_bar_space + status_bar_width) + status_bar_space;
    status_panel_y = move_lock_y - 32;
        
    for(i=1; i<=status_count; i++)
    {
        status_color = status_order[? i];
        status_tint = DB.colormap[? status_color];
        if(status_color == g_black)
        {
            status_tint = DB.colormap[? g_white];
        }
        if(status_color == g_octarine)
        {
            status_tint = singleton_obj.octarine_tint;
        }
        
        bar_alpha = 1;
        
        effect = DB.color_effects[? status_color];
        status_icon = effect.icon;
        
        if(my_guy.status_left[? effect.codename] <= 0)
        {
            bar_height = 0;
            
            if( (singleton_obj.step_count - status_last_active[? effect.codename]) > card_hide_inactive_delay )
            {
                status_card_visible[? effect.codename] = false;
            }
        }
        else
        {
            bar_height = (my_guy.status_left[? effect.codename] / effect.max_charge)*status_panel_height;
            status_last_active[? effect.codename] = singleton_obj.step_count;
            
            if(my_guy.status_left[? effect.codename] > card_show_min_status_left)
            {
                status_card_visible[? effect.codename] = true;
            }
        }
        
        if(status_card_visible[? effect.codename] && status_icon != noone)
        {
            if(status_icon != noone)
            {
                xx += status_bar_space + status_bar_width/2;   
                var xxx = ceil(xx - panel_width/2);
                
                var card_left = xxx - card_half;
                var card_right = xxx + card_half;

                // BG
                draw_set_colour(c_black);
                draw_set_alpha(card_alpha);
                draw_rectangle(card_left, status_panel_y - 23, card_right, status_panel_y + 24, false);
                
                // FILL
                draw_set_alpha(card_alpha/2);
                draw_set_colour(c_white);
                draw_rectangle(card_left, status_panel_y + 24 - bar_height, card_right, status_panel_y + 24, false);
                
                // OUTLINE
                draw_rectangle(card_left, status_panel_y - 24, card_right, status_panel_y + 24, true);
                
                // ICON
                draw_set_alpha(1);
                draw_sprite_ext(status_icon, 0, xxx, status_panel_y /*- bar_height*/, 0.75, 0.75, 0, status_tint, bar_alpha);
                
                xx += status_bar_width/2;
            }
        }
    }
    
    // ABI PANEL
    // TODO: could use optimisation
    if(mod_get_state("abilities") && show_abilities)
    {
        var group_count, group, group_members, i, ii, abi_level,
            bar_height, bar_color, bar_tint, bar_alpha, icon_alpha, outline_alpha;
        var xx = abi_panel_x;
        var panel_top = abi_panel_y - abi_panel_height;
    
        group_count = ds_map_size(abi_groups);
        for(i=1; i<=group_count; i++)
        {
            group = abi_groups[? i];
            group_members = ds_map_size(group);
        
            for(ii=1; ii<=group_members; ii++)
            {
                bar_color = group[? ii];
                abi_level = get_level(my_guy, DB.abimap[? bar_color]);
            
                if(!mod_get_state("black_color") && bar_color == g_black)
                    continue;
                    
                // HAS ABI COLOR? 
                if(abi_level >= 1)
                {
                    xx += abi_bar_space;  
                    abi_icon = DB.abi_icons[? bar_color];
                    
                    if(my_guy.abi_cooldown[? bar_color] == 0 || my_guy.abi_cooldown_length[? bar_color] == 0)
                    {
                        bar_tint = DB.colormap[? bar_color];  
                        bar_height = abi_panel_height;
                        outline_alpha = 1;
                        bar_alpha = 1;
                        icon_alpha = 1;            
                    }
                    else if(my_guy.abi_cooldown[? bar_color] > 0)
                    {
                        bar_tint = DB.colormap[? bar_color];  
                        //bar_tint = merge_color(g_black, DB.colormap[? bar_color], 0.5);
                        bar_height = (1-(my_guy.abi_cooldown[? bar_color] / my_guy.abi_cooldown_length[? bar_color]))*abi_panel_height;
                        //bar_height = sqr(1-(my_guy.abi_cooldown[? bar_color] / my_guy.abi_cooldown_length[? bar_color]))*abi_panel_height;
                        outline_alpha = 0.25;
                        bar_alpha = 0.75;
                        icon_alpha = 0.25;
                    }
                
                    /*
                    if(bar_color == g_white)
                    {
                        draw_set_colour(c_black);
                    }
                    else
                    {
                        draw_set_colour(c_white);
                    }*/
                    
                    
                    
                    var bar_x1 = xx;
                    var bar_x2 = xx + abi_bar_width - 1;
                    
                    // BACKGROUND
                    draw_set_colour(abi_bg_color);
                    draw_set_alpha(outline_alpha * 0.2);
                    draw_rectangle(bar_x1, panel_top,
                        bar_x1 + abi_bar_width, abi_panel_y, false);
                
                    // OUTLINE
                    draw_set_colour(abi_outline_color);
                    draw_set_alpha(outline_alpha);
                    
                    draw_rectangle(bar_x1 - abi_outline_size, panel_top - abi_outline_size,
                        bar_x2 + abi_outline_size, panel_top - 1, false);
                    
                    draw_rectangle(bar_x1 - abi_outline_size, panel_top,
                        bar_x1 - 1, abi_panel_y, false);
                    
                    draw_rectangle(bar_x2 + 1, panel_top,
                        bar_x2 + abi_outline_size, abi_panel_y, false);
                        
                
                    // BAR    
                    draw_set_alpha(bar_alpha);
                    draw_set_colour(bar_tint);
                    draw_rectangle(bar_x1, abi_panel_y - bar_height,
                                    bar_x2, abi_panel_y, false);
        
                    // ABI ICON
                    if(abi_icon != noone)
                    {
                        var icon_x = floor(bar_x1 + abi_bar_width/2);
                        //var icon_y = panel_top - 24;
                        var icon_y = floor(panel_top + abi_panel_height/2);
                        
                                            
                        repeat(abi_level)
                        {
                            
                            draw_set_colour(c_black);
                            draw_set_alpha(icon_alpha * 0.4);
                            //draw_circle(icon_x - 0.499, icon_y - 0.499, abi_panel_icon_bg_radius, false);
                            draw_ellipse(icon_x - abi_panel_icon_bg_radius, icon_y - abi_panel_icon_bg_radius,
                                        icon_x + abi_panel_icon_bg_radius - 1, icon_y + abi_panel_icon_bg_radius - 1, false);
                    
                            draw_set_colour(c_white);
                            draw_set_alpha(icon_alpha);
                            draw_sprite(abi_icon, 0, icon_x, icon_y);
                            
                            icon_y -= 40;
                        }
                    }
                                
                    xx += abi_bar_width;
                }
            }
        
            xx += abi_group_space;
        }
    }
    
    // ORB STORAGE NUMBERS
    if(!hide_storage)
    {
        number_y = slots_y + 24;
        draw_set_alpha(1);
        my_draw_set_font(label_font);
        
        for(i=1;i<=3;i++)
        {
            number_x = abi_x + ((4-i)-0.5)*slot_size + slot_offset;
            if(i==3)
                i=4;
            number_str = string(last_orbs[? i]);
            orb_tint = merge_colour(DB.colormap[? i], c_white, orb_light[? i]*0.9);
            
            draw_sprite_ext(color_orb_icon, 0, number_x, number_y, 1+orb_light[? i],1+orb_light[? i],0, orb_tint, 0.8);
            
            draw_set_color(c_black);
            my_draw_text(number_x+2, number_y+2, number_str);
            
            draw_set_color(c_white);
            my_draw_text(number_x, number_y, number_str);
        }
    }
    
    // ORB BELTS AND ORBITS
    
    // CHARGE BALL ORBIT
    if(instance_exists(my_guy.charge_ball) && show_chargeball_orbit)
    {
        var orbit_x = orb_panel_x;
        if(screen_side == 0 || screen_side == 1)
        {
            orbit_x += (4 - my_guy.charge_ball.max_orbs) * orb_belt_width;
        }
        
        draw_orb_belt_gui(orbit_x,
                          orb_panel_y - orb_panel_height - (1.5 * orb_belt_width), 
                          my_guy.charge_ball.orbs, "horizontal", orb_belt_width,
                          my_guy.charge_ball.max_orbs, my_guy.my_player.my_camera);
    }

    
    // GUY ORBIT (intergrated into belts)
    //draw_orb_belt_gui(orb_panel_x+(4-my_guy.slot_maxnumber)*orb_belt_width, orb_panel_y -orb_panel_height -1.5*orb_belt_width, my_guy.color_slots, "horizontal", orb_belt_width, my_guy.slot_maxnumber);
    
    /*
    // BACKGROUND
    draw_set_alpha(0.4);
    draw_set_colour(c_white);
    draw_rectangle(orb_panel_x,orb_panel_y,
        orb_panel_x+orb_panel_width, orb_panel_y-orb_panel_height, false);
        */
    
            
    // GUY BELTS
    if(show_belts)
    {
        var x_offset = 0;
        
        for(i = 0; i < belt_count; i++)
        {
            col = belt_order[| i]
            {
                if(show_belt[? col])
                {
                    var tint = DB.colormap[? col];
                    var list = belt_list[? col];
                    var y_offset = belt_size*orb_belt_width;
                    if (col == g_black) 
                    {
                        y_offset = orb_belt_width;
                    }
                    draw_orb_belt_gui(orb_panel_x + x_offset, orb_panel_y - y_offset,
                                      list, "vertical", orb_belt_width,
                                      my_guy.belt_size[? col], my_guy.my_player.my_camera);
                    
                    x_offset += orb_belt_width; 
                }    
            }
            col++;
        }
    }
    
    // ROTATING ARROW
    /*
    if(gamemode_obj.player_count == 1)
    {
        draw_sprite_ext(rotating_arrow_spr, rotating_arrow_image, x, name_offset+16,1,1,0,singleton_obj.octarine_tint, rotating_arrow_alpha);
    }
    */
    
    
    name_alpha = base_name_alpha;
    if(my_guy.seated || instance_exists(speech_popup_obj))
    {
        name_alpha = speaking_name_alpha;
    }
    
    // FULL ID DISPLAY
    if(gamemode_obj.player_count > 1)
    {
        // PLAYER ICON DISPLAY
        /*
        draw_sprite_ext(player_icon_bg, 0, x, name_offset-icon_dist,1,1,0,c_white,0.3);
        */
    
        //draw_sprite_ext(my_guy.my_player.icon, 0, x, name_offset-16,1,1,0,c_white,0.8); //name_offset-icon_dist
    
    
        // PLAYER TITLE DISPLAY
        var title_str = my_guy.my_player.title;
    
        if(title_str != "")
        {
            draw_set_halign(fa_middle);
            draw_set_valign(fa_top);
            my_draw_set_font(text_popup_font);
        
            draw_set_color(c_ltgray);
            draw_set_alpha(0.33*name_alpha);
            for(i=-1;i<=1;i+=1) {
                for(ii=-1;ii<=1;ii+=1)
                {
                    my_draw_text(x+i, name_offset-1+ii, title_str);
                }
            }
            
            draw_set_alpha(name_alpha);
            draw_set_color(c_white);
            my_draw_text(x, name_offset-1, title_str);
            draw_set_halign(fa_left);
        }
    }
        
    // PLAYER NAME DISPLAY
    var name_str = my_guy.name;
    
    //name_offset -= 64;
    name_offset -= 32;
        
    draw_set_halign(fa_middle);
    draw_set_valign(fa_top);
    my_draw_set_font(text_popup_font);
    
    draw_set_color(c_white); //c_ltgray
    draw_set_alpha(0.33*name_alpha);
    for(i=-1;i<=1;i+=1) {
        for(ii=-1;ii<=1;ii+=1)
        {
            my_draw_text(x+i, name_offset-1+ii, name_str);
        }
    }
    
    draw_set_alpha(name_alpha);
    draw_set_color(c_white);
    my_draw_text(x, name_offset-1, name_str);
    draw_set_halign(fa_left);
    
    
    // ATTACK DIRECTION
    /*
    if(my_guy.charging && instance_exists(my_guy.charge_ball))
    {
        ball = my_guy.charge_ball;

        attack_color = ball.tint;
        
        if(ball.desired_dist != 0)
        {
            att_dir = point_direction(0,0,ball.rel_x,ball.rel_y);
            att_x = lengthdir_x(att_draw_dist,att_dir);
            att_y = lengthdir_y(att_draw_dist,att_dir);
            draw_sprite_ext(curved_arrow_spr,0,x + att_x, guy_y + att_y, 1,1, att_dir, c_white,0.66);
            draw_sprite_ext(curved_arrow_spr,0,x + att_x, guy_y + att_y, 0.75,0.75, att_dir, attack_color,0.66);

            //draw_sprite_ext(curved_arrow_spr, 0, x + ball.rel_x, guy_y + ball.rel_y, 1,1, att_dir, c_white, 0.66);
        }
        else
        if(ball.desired_dist == 0 && ball.cur_dist < 8)
        {
            draw_sprite_ext(shield_hint_spr,0,x, guy_y, 1,1, 0, c_white,0.4);
            draw_sprite_ext(shield_hint_spr,0,x, guy_y, 0.75,0.75, 0, attack_color,0.4);
        }
    }
    */
    
    // MOVE LOCK
    if(my_guy.wanna_look)
        draw_sprite_ext(move_lock_icon, 0, x, move_lock_y, 1, 1, 0, c_white, 0.8); 
}
