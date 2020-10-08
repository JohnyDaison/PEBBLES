if(!gamemode_obj.limit_reached)
{
    draw_set_alpha(1);
    
    // BASE
    draw_set_color(c_white);
    draw_sprite(sprite_index, 0, gui_x, gui_y);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // GLOW
    draw_sprite_ext(sprite_index, 1, gui_x,gui_y, 1,1,0, DB.colormap[? shot_color], 1);
    
    // ARROW
    if(instance_exists(charge_ball))
    {
        var dir = point_direction(x,y,charge_ball.x,charge_ball.y);
        draw_sprite_ext(curved_arrow_spr, 0, 
            gui_x + lengthdir_x(arrow_dist, dir),
            gui_y + lengthdir_y(arrow_dist, dir),
            2,1, dir, c_white, 0.9);
    }
    
    // HP
    if(damage < hp)
    {
        //hp_str = string(ceil((hp-damage)*100));
        hp_ratio = (hp-damage)/hp;
        //draw_sprite(cannon_ammo_spr, 0, gui_x, gui_y+hp_y_offset);
        /*
        my_draw_set_font(hp_font);
        draw_set_color(c_black);
        my_draw_text(gui_x+2, gui_y+hp_y_offset+2, hp_str);
        draw_set_color(c_yellow);
        my_draw_text(gui_x, gui_y+hp_y_offset, hp_str);
        */
        
        hpbar_xx = hpbar_x1 + hp_ratio*hpbar_width;
        
        // BG
        draw_set_colour(c_dkgray);
        draw_rectangle(gui_x + hpbar_x1, gui_y + hpbar_y1, 
            gui_x + hpbar_x2, gui_y + hpbar_y2, false);
        
        // BAR
        draw_set_colour(hpbar_tint);
        draw_rectangle(gui_x + hpbar_x1, gui_y + hpbar_y1, 
            gui_x + hpbar_xx, gui_y + hpbar_y2, false);
           
        // COVER
        draw_sprite(cannon_hpbar_cover_spr, 0, gui_x, gui_y);
    }
    
    // ORB NUMBERS
    number_y = gui_y + 80;
    slot_size = 24;
    slot_offset = -slot_size*1.5;
    my_draw_set_font(label_font);
    
    for(i=1;i<=3;i++)
    {
        number_x = gui_x + ((4-i)-0.5)*slot_size + slot_offset;
        if(i==3)
            i=4;
            
        number_str = string(orbs[? i]);
        orb_tint = merge_colour(DB.colormap[? i], c_white, orb_light[? i]*0.9);
        
        draw_sprite_ext(color_orb_icon, 0, number_x, number_y, 1+orb_light[? i],1+orb_light[? i],0, orb_tint, 0.8);
        
        draw_set_color(c_black);
        my_draw_text(number_x+2, number_y+2, string_hash_to_newline(number_str));
        
        draw_set_color(c_white);
        my_draw_text(number_x, number_y, string_hash_to_newline(number_str));
    }
    
    // OUT OF AMMO
    if(instance_exists(ammo_popup))
    {
        my_draw_set_font(ammo_popup.font);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_alpha(1);
        draw_set_color(ammo_popup.tint - c_gray);
        my_draw_text(gui_x + ammo_x - 1, gui_y + ammo_y - 1, string_hash_to_newline(ammo_popup.str));
        my_draw_text(gui_x + ammo_x + 1, gui_y + ammo_y + 1, string_hash_to_newline(ammo_popup.str));
        draw_set_color(ammo_popup.tint);
        my_draw_text(gui_x + ammo_x, gui_y + ammo_y, string_hash_to_newline(ammo_popup.str));
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);           
    }
}

event_inherited();