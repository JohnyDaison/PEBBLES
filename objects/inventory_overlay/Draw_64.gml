if(inv_size != -1)
{
    if(instance_exists(my_player) && instance_exists(my_guy) && view_enabled && draw_inventory)
    {
        my_camera = my_player.my_camera;
        if(instance_exists(my_camera))
        {   
            var offset_set = false;
            if(view_get_visible( my_camera.view ))
            {
                self.view_x_offset = view_get_xport( my_camera.view );
                self.view_y_offset = view_get_yport( my_camera.view );
                offset_set = true;
            }
            else if(view_get_visible( main_camera_obj.view ))
            {
                self.view_x_offset = view_get_xport( main_camera_obj.view ) + (view_get_wport( main_camera_obj.view )/2)*(my_camera.view-1);
                self.view_y_offset = view_get_yport( main_camera_obj.view );
                offset_set = true;
            }
            if(!offset_set)
            {
                  self.view_x_offset = view_get_xport( 0 ) + (view_get_wport( 0 )/2)*(my_camera.view-1);
                  self.view_y_offset = view_get_yport( 0 );
            }
            
            draw_set_alpha(bg_alpha);
            
            if(my_guy.control_method == keyboard || my_guy.control_method == gamepad)
            {
                // OVERLAY POSITION
                if(my_guy.control_method == keyboard)
                {
                    width = inv_size*slot_size + (inv_size-1)*slot_dist;
                    height = name_height + slot_size;
                
                    x = my_camera.border_width + slot_dist + self.view_x_offset;
                    y = my_camera.border_width + self.view_y_offset + 32; // +32 because of time window
                }
                if(my_guy.control_method == gamepad)
                {
                    width = slot_size + 2*slot_range;
                    height = slot_size + 2*slot_range;
                
                    x = my_camera.border_width + width/2 + slot_dist + self.view_x_offset;
                    y = my_camera.border_width + height/2 + slot_dist + self.view_y_offset;
                }
                
                y += 48; // for HP bar
                
                offset_x = x;
                offset_y = y;
                
                var view_center_x = view_get_xport( my_camera.view ) + view_get_wport( my_camera.view )/2;
                var view_center_y = view_get_yport( my_camera.view ) + view_get_hport( my_camera.view )/2;
            
                var i, pickup, xx, yy, alpha_ratio;
                for(i=1; i<=inv_size; i+=1)
                {
                    pickup = my_guy.inventory[? i];
    
                    alpha_ratio = 0.8;
    
                    // SLOT POSITION
                    if(my_guy.control_method == keyboard)
                    {
                        xx = slot_size / 2 + (i-1) * (slot_size + slot_dist);
                        yy = name_height + slot_size / 2;
                    }
                    if(my_guy.control_method == gamepad)
                    {
                        xx = lengthdir_x(slot_range, i*90);
                        yy = lengthdir_y(slot_range, i*90);
                    }
                    
                    var final_x = x + xx;
                    var final_y = y + yy;
                    
                    //draw_circle_colour(x + xx, y + yy, bg_radius, bg_tint[? i], bg_tint[? i] ,false);
                    
                    if(instance_exists(pickup))
                    {
                        // TODO: THIS SHOULD BE IN STEP
                        if (last_pickup[? i] != pickup || last_stacksize[? i] < pickup.stack_size)
                        {
                            bg_tint[? i] = get_tint;
                            blink_tint[? i] = get_tint;
                            blink_start[? i] = singleton_obj.step_count;
                        }
                        if (last_stacksize[? i] > pickup.stack_size)
                        {
                            bg_tint[? i] = red_tint;
                            blink_tint[? i] = red_tint;
                            blink_start[? i] = singleton_obj.step_count;
                        }
                        if (my_guy.full_inv_blink)
                        {
                            bg_tint[? i] = red_tint;
                            blink_tint[? i] = red_tint;
                            blink_start[? i] = singleton_obj.step_count;
                        }
                        
                        
                        // DRAW BG
                        draw_sprite_ext(bg_sprite, 0, final_x, final_y, 1, 1, 0, bg_tint[? i], bg_alpha);

                        
                        // DRAW ICON
                        var icon_tint = pickup.tint;
                        if(pickup.activatable && pickup.active)
                        {
                            alpha_ratio = 1;
                        }
                        if(pickup.reserved) 
                        {   if(pickup.stack_size == 0)
                            {
                                alpha_ratio = 0.5;
                                icon_tint = c_gray;
                            }
                        }
                        
                        var size_coef = 0,
                        size_boost = 0,
                        anim_progress;
                        
                        var sprite_x = final_x-1,
                            sprite_y = final_y-1
                        
                        if(pickup.newly_got_steps > 0)
                        {
                            anim_progress = (1 - (pickup.newly_got_steps / pickup.newly_got_anim_duration));
                            size_coef = (1- ( abs(pickup.newly_got_steps - pickup.newly_got_anim_peak) / pickup.newly_got_anim_peak));
                            size_boost = pickup.newly_got_anim_sizecoef * size_coef;
                            
                            sprite_x = lerp(view_center_x, sprite_x, anim_progress);
                            sprite_y = lerp(view_center_y, sprite_y, anim_progress);
                        }
                        
                        draw_sprite_ext(pickup.inventory_spr, 0, sprite_x, sprite_y, 1+size_boost, 1+size_boost, 0, icon_tint, min(1, alpha_ratio)); //pickup.image_alpha*
                        
                        if (pickup.object_index == flag_obj) {
                            var flag_tint = decide_flag_tint(pickup.my_flag_spawner, my_guy);
                            
                            draw_sprite_ext(pickup.flag_icon, 0, sprite_x, sprite_y, 0.5 * (1+size_boost), 0.5 * (1+size_boost), 0, flag_tint, min(1, alpha_ratio) * pickup.flag_alpha);
                        }
                        
                        if(pickup.use_cooldown_left > 0)
                        {
                            //draw_sprite(move_lock_icon, 0, final_x-1, final_y-1);
                            var status = floor(12*pickup.use_cooldown_left/pickup.use_cooldown_length);
                            draw_sprite_ext(outer_dial_small_spr,status, final_x-1, final_y-1,1,1,0,c_red,0.9);
                        }
                        
                        // DRAW LABEL
                        draw_set_alpha(0.8);
                        /*
                        my_draw_set_font(inventory_font);
                        draw_set_halign(fa_center);
                        draw_set_valign(fa_middle);
                        var label_height = string_height_ext(pickup.name, 14, slot_size+slot_dist);
                        if(my_guy.control_method == keyboard)
                        {
                            var label_y = final_y + (slot_size+label_height/2) * ((i mod 2) -0.5);
                        }
                        if(my_guy.control_method == gamepad)
                        {
                            name_adjust = 0;
                            if(i==1)
                                name_adjust = -label_height/2;
                            var label_y = final_y -4; // + (slot_size+label_height/2) * -0.5 + name_adjust;
                        }
                        draw_set_color(c_black);
                        my_draw_text_ext(final_x -1, label_y -1, pickup.name, 14, slot_size+slot_dist);
                        my_draw_text_ext(final_x +1, label_y +1, pickup.name, 14, slot_size+slot_dist);
                        draw_set_color(c_white);
                        my_draw_text_ext(final_x, label_y, pickup.name, 14, slot_size+slot_dist);
                        */
                        
                        if(pickup.stack_size > 1 || pickup.reserved)
                        {
                            final_x += stack_xx;
                            final_y += stack_yy;
                            var str = string(pickup.stack_size);
                            
                            my_draw_set_font(stack_font);
                            draw_set_halign(fa_center);
                            draw_set_valign(fa_middle);
    
                            draw_set_colour(c_gray);
                            draw_ellipse(final_x - stack_radius, final_y - stack_radius,
                                         final_x + stack_radius -1, final_y + stack_radius -1, false);
                            draw_set_colour(c_black);
                            my_draw_text_ext(final_x+1, final_y+1, str, 20, 200);
                            draw_set_colour(c_white);
                            my_draw_text_ext(final_x, final_y, str, 20, 200);
                        }
                        
                        last_stacksize[? i] = pickup.stack_size;
                    }
                    else
                    {
                        if (last_pickup[? i] != pickup || last_stacksize[? i] != 0) {
                            bg_tint[? i] = red_tint;
                        }
                        
                        draw_sprite_ext(bg_sprite, 0, x + xx, y + yy, 1, 1, 0, bg_tint[? i], bg_alpha * empty_bg_alpha_coef);
                        
                        last_stacksize[? i] = 0;
                    }
            
                    last_pickup[? i] = pickup;
                }
            }
            
            draw_set_alpha(1);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
    }
}
