if(instance_exists(my_player) && view_enabled)
{
    if(!instance_exists(my_camera))
    {
        my_camera = my_player.my_camera;
    }
        
    if(stage > 0)
    {
        offset_set = false;
        if(__view_get( e__VW.Visible, my_camera.view ))
        {
            self.view_x_offset = __view_get( e__VW.XPort, my_camera.view );
            self.view_y_offset = __view_get( e__VW.YPort, my_camera.view );
            offset_set = true;
        }
        if(!offset_set)
        {
              self.view_x_offset = __view_get( e__VW.XPort, 0 )+640*(my_camera.view-1);
              self.view_y_offset = __view_get( e__VW.YPort, 0 );
        }
    
        x = my_camera.border_width * 2;
        y = my_camera.border_width * 2 + 25;
        
        offset_x = x+self.view_x_offset;
        offset_y = y+self.view_y_offset;
        
        self.width =  __view_get( e__VW.WPort, my_camera.view ) - my_camera.border_width * 4;
        self.height = 0;
        for(i=1; i<=2; i+=1)
        {
            if(stage >= i)
                self.height += stageheight[i];
        }

        draw_set_alpha(self.stage_alpha + self.stage_alpha_step*stage);
        if(self.draw_bg_color)
        {
            draw_set_color(self.bg_color);
            draw_roundrect(offset_x,offset_y,offset_x+self.width,offset_y+self.height,false)
        }
        draw_set_alpha(1);
        if(self.draw_border)
        {
            draw_set_color(self.border_color);
            draw_roundrect(offset_x,offset_y,offset_x+self.width,offset_y+self.height,true)
        }
    }
    
    if(stage >= 1)
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        my_draw_set_font(self.font);
        
        //name_size = min(max(128,string_width(my_player.name)),256);
        
        offset_x += width/4-32;
        
        // PLAYER NAME AND DAMAGE WITH SHADOW
        draw_set_color(c_white - self.color);
        i=1;
        repeat(2)
        {
            my_draw_text(offset_x+i,offset_y+i,string_hash_to_newline(my_player.name));
                                
            my_draw_text(offset_x-48+i,offset_y+32+i,string_hash_to_newline(string(ds_map_find_value(my_player.stats,"score"))));
                        
            //my_draw_text(offset_x+i,offset_y+32+i,"|")
            if(i==0)
            {
                col_ratio = min(my_guy.damage/24,1);
                draw_set_color(merge_color(c_green,c_red,col_ratio));
            }
            my_draw_text(offset_x+48+i,offset_y+32+i,string_hash_to_newline(string(round(my_guy.damage*100))+"%"))
            
            draw_set_color(self.color);                        
            i=0;
        }
        
        offset_x = x+self.view_x_offset+width/2+1;
        
        draw_set_alpha(self.stage_alpha);
        draw_set_color(self.bg_color);
        draw_roundrect(offset_x-31,offset_y+2,offset_x+30,offset_y+62,false);
        draw_set_alpha(1);
        draw_set_color(self.border_color);
        draw_roundrect(offset_x-31,offset_y+2,offset_x+30,offset_y+62,true);
        
        // SHIELD RECHARGE INDICATOR
        
        shield_size = 1-(my_guy.alarm[4]/my_guy.shield_repair_time);
        if(instance_exists(my_guy.my_shield))
        {
            shield_color = my_guy.my_shield.my_color;
        }
        else
        {
            shield_color = g_dark;
        }
        shield_tint = ds_map_find_value(DB.colormap,shield_color);
        draw_sprite_ext(shield_sprite,image_index,offset_x,offset_y+32,shield_size,shield_size,0,shield_tint,0.6);

        
        // SLOTS DISPLAY
        
        slot = ds_list_find_value(my_guy.color_slots,0);
        slot_color = my_guy.my_color;
        if(instance_exists(slot))
        {
            if(slot.color_held && slot.my_color == g_dark)
            {
                slot_color = slot.my_color;
            }
        }

        slot_tint = ds_map_find_value(DB.colormap,slot_color);
        
        if(slot_color == g_dark)
        {   
            draw_sprite_ext(color_slot,image_index*2,offset_x-1,offset_y+31,2,2,0,slot_tint,0.8);
        }
        else
        {
            for(i=0;i < my_guy.slots_absorbed;i+=1)
            {
                draw_sprite_ext(color_slot,image_index*2,offset_x,offset_y+40+(16*my_guy.slot_maxnumber)*(i/my_guy.slot_maxnumber-0.5),1,1,0,slot_tint,0.8);
            }
            
            for(i=i;i < my_guy.slot_number;i+=1)
            {
                draw_sprite_ext(color_slot,image_index*2,offset_x,offset_y+40+(16*my_guy.slot_maxnumber)*(i/my_guy.slot_maxnumber-0.5),1,1,0,c_ltgray,0.6);
            }
        }
        
        
        /*
        // SLOT STATE
        draw_set_color(c_white - self.color);
        i=1;
        repeat(2)
        {
            my_draw_text(offset_x+290+i,offset_y+32+i,string(my_guy.current_slot)+"/"+string(my_guy.slot_number)+"/"+string(my_guy.slot_maxnumber)+"-"+string(my_guy.slots_triggered));
            
            draw_set_color(self.color);                        
            i=0;
        }
        */
        
        offset_x = x+self.view_x_offset+width;
        
        // RIGHT COLUMN
        rightside = offset_x - 16;
        abi_width = width/2 - 64;
        effect_divide = 5;
        effect_width = (abi_width-5*effect_divide)/6;
        
        leftside = rightside - abi_width;
        
        // ABI COOLDOWN            
        
        if(my_guy.abi_cooldown > 0)
        {
            amount = 100*my_guy.abi_cooldown/my_guy.abi_cooldown_length;
        }
        else
        {
            amount = 0;
        }
        draw_healthbar(leftside,offset_y+6,rightside,offset_y+29,amount,c_dkgray,c_green,c_red,0,true,false);
        
        // EFFECT METERS
        /*
        for(i=g_red; i<g_white; i+=1)
        {
            col = ds_map_find_value(DB.colormap,i);
            
            with(my_guy)
            {
                switch(other.i)
                {
                    case g_red:
                         val = burn_left/max_burn_time;
                         break;
                    case g_green:
                         val = frozen_left/max_frozen_time;
                         break;
                    case g_blue:
                         val = slow_left/max_slow_time;
                         break;
                    case g_yellow:
                         val = conf_left/max_conf_time;
                         break;
                    case g_magenta:
                         val = weak_left/max_weak_time;
                         break;
                    case g_cyan:
                         val = bounce_left/max_bounce_time;
                         break;
                }
                
                val = min(val,1);
                val = max(val,0);
            }
            

            draw_set_color(c_dkgray);
            draw_rectangle(leftside+(i-1)*(effect_width+effect_divide),offset_y+35,leftside+(i-1)*(effect_width+effect_divide)+effect_width,offset_y+58,false);
            draw_set_color(col);
            draw_rectangle(leftside+(i-1)*(effect_width+effect_divide),offset_y+35,leftside+(i-1)*(effect_width+effect_divide)+my_guy.val*effect_width,offset_y+58,false);

            //draw_set_color(c_black);
            //draw_rectangle(leftside+(i-1)*effect_width,offset_y+35,leftside+i*effect_width,offset_y+58,true);
            
        }*/
        
        
        //offset_x = x+self.view_x_offset+width;
        
        /*
        draw_set_halign(fa_right);
        draw_set_valign(fa_top);
        draw_set_color(self.color);
        
        // LAST ATTACKER TEXT WITH SHADOW
        if(instance_exists(my_guy.last_attacker))
        {         
            if(my_guy.last_attacker.object_index == player_obj)
            {
                draw_set_color(c_white - self.color);
                i=1;
                repeat(2)
                {
                    my_draw_text(offset_x-16+i,offset_y+32+i,my_guy.last_attacker.name);
                    
                    draw_set_color(self.color);                        
                    i=0;
                }
            }
            else
            {
                draw_set_color(c_white - self.color);
                i=1;
                repeat(2)
                {
                    my_draw_text(offset_x-16+i,offset_y+32+i,string(my_guy.last_attacker.id));
                    
                    draw_set_color(self.color);                        
                    i=0;
                }
            }
        }
        */
                          
    }
    
    if(stage >= 2)
    {
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        my_draw_set_font(label_font);
        
        offset_x = x+self.view_x_offset;
        offset_y = y+self.view_y_offset;
        
        offset_x += 32;
        offset_y += stageheight[1]+16;
        
        // TEXT WITH SHADOW
        draw_set_color(c_white - self.color);
        i=1;
        repeat(2)
        {
            my_draw_text(offset_x+i,offset_y+i,string_hash_to_newline("Kills: "+string(ds_map_find_value(my_player.stats,"kills"))));
            my_draw_text(offset_x+160+i,offset_y+i,string_hash_to_newline("Longest streak: "+string(ds_map_find_value(my_player.stats,"best_killstreak"))));
            
            my_draw_text(offset_x+i,offset_y+32+i,string_hash_to_newline("Deaths: "+string(ds_map_find_value(my_player.stats,"deaths"))));
            my_draw_text(offset_x+160+i,offset_y+32+i,string_hash_to_newline("Longest streak: "+string(ds_map_find_value(my_player.stats,"best_deathstreak"))));
            
            my_draw_text(offset_x+i,offset_y+64+i,string_hash_to_newline("Spells: "+string(ds_map_find_value(my_player.stats,"spells"))));
            my_draw_text(offset_x+160+i,offset_y+64+i,string_hash_to_newline("Longest streak: "+string(ds_map_find_value(my_player.stats,"best_spellstreak"))));
            
            my_draw_text(offset_x+160+i,offset_y+96+i,string_hash_to_newline("Longest combo: "+string(ds_map_find_value(my_player.stats,"best_combo"))));
                            
            my_draw_text(offset_x+i,offset_y+128+i,string_hash_to_newline("Abilities: "+string(ds_map_find_value(my_player.stats,"abilities"))));
            my_draw_text(offset_x+160+i,offset_y+128+i,string_hash_to_newline("Longest streak: "+string(ds_map_find_value(my_player.stats,"best_abilitystreak"))));
            
            draw_set_color(self.color);                        
            i=0;
        }
    }
}

/* */
/*  */
