action_inherited();
if(self.ready && self.on)
{
    // BACKGROUND
    draw_set_alpha(bg_alpha);
    draw_set_color(__background_get_colour( ));
    draw_rectangle(minimap_left-mini_block_size,minimap_top-mini_block_size,minimap_right+mini_block_size,minimap_bottom+mini_block_size,false);
    
    // TERRAIN
    with(terrain_obj)
    {
        draw_set_alpha(other.map_alpha);
        draw_set_color(self.tint);
    
        minimap_x = other.minimap_view_left + floor(x/32 * other.mini_block_size) - floor(__view_get( e__VW.XView, other.my_camera.view )/32)*other.mini_block_size;
        minimap_y = other.minimap_view_top + floor(y/32 * other.mini_block_size) - floor(__view_get( e__VW.YView, other.my_camera.view )/32)*other.mini_block_size;
        
        if(minimap_x >= other.minimap_left && minimap_x <= other.minimap_right - (other.mini_block_size-1)
        && minimap_y >= other.minimap_top && minimap_y <= other.minimap_bottom - (other.mini_block_size-1))
        {
            draw_rectangle(minimap_x, minimap_y, minimap_x + (other.mini_block_size-1), minimap_y + (other.mini_block_size-1), false);
            /*
            draw_set_alpha(other.map_alpha/10);
            draw_set_color(background_color);        
            draw_rectangle(minimap_x, minimap_y, minimap_x + (other.mini_block_size-1), minimap_y + (other.mini_block_size-1), true);
            */
        }
    }
    
    // BIG PROJECTILES
    with(big_projectile_obj)
    {
        with(other)
        {
            draw_set_alpha(map_alpha);
            
            minimap_x = minimap_view_left + floor(other.x/32 * mini_block_size) - floor(__view_get( e__VW.XView, my_camera.view )/32)*mini_block_size;
            minimap_y = minimap_view_top + floor(other.y/32 * mini_block_size) - floor(__view_get( e__VW.YView, my_camera.view )/32)*mini_block_size;
            
            if(minimap_x >= minimap_left && minimap_x <= minimap_right - (mini_block_size-1)
            && minimap_y >= minimap_top && minimap_y <= minimap_bottom - (mini_block_size-1))
            {
                draw_sprite_ext(minimap_bigbolt_spr,0,minimap_x,minimap_y,1,1,0,other.tint,1);
            }
        }
    }
    
    // SMALL PROJECTILES
    with(small_projectile_obj)
    {
        with(other)
        {
            draw_set_alpha(map_alpha);
            
            minimap_x = minimap_view_left + floor(other.x/32 * mini_block_size) - floor(__view_get( e__VW.XView, my_camera.view )/32)*mini_block_size;
            minimap_y = minimap_view_top + floor(other.y/32 * mini_block_size) - floor(__view_get( e__VW.YView, my_camera.view )/32)*mini_block_size;
            
            if(minimap_x >= minimap_left && minimap_x <= minimap_right - (mini_block_size-1)
            && minimap_y >= minimap_top && minimap_y <= minimap_bottom - (mini_block_size-1))
            {
                draw_sprite_ext(minimap_smallbolt_spr,0,minimap_x,minimap_y,1,1,0,other.tint,1);
            }
        }
    }
    
    // BEAMS
    with(beam_obj)
    {
        if(endpoint_reached && !invalid)
        {
            with(other)
            {
                draw_set_color(other.tint);
                
                if(!other.collided)
                {
                    node = ds_list_find_value(other.beam_nodes,0);
                    start_x = node.x;
                    start_y = node.y;
                    
                    minimap_start_x = minimap_view_left + start_x/32 * mini_block_size - floor(__view_get( e__VW.XView, my_camera.view )/32)*mini_block_size -1;
                    minimap_start_y = minimap_view_top + start_y/32 * mini_block_size - floor(__view_get( e__VW.YView, my_camera.view )/32)*mini_block_size -1;
                    minimap_end_x = minimap_left + minimap_width *(other.facing+1)/2;
                    
                    draw_set_alpha(map_alpha/2);
                    draw_line_width(minimap_start_x,minimap_start_y,minimap_end_x,minimap_start_y,3);
                    draw_set_alpha(map_alpha);
                    draw_line(minimap_start_x,minimap_start_y,minimap_end_x,minimap_start_y);
                    
                }
                else
                {
                    for(i=1;i<=other.last_node;i+=1)
                    {
                        if(i==1)
                        {
                            prev_node = ds_list_find_value(other.beam_nodes,i-1);
                        }
                        else
                        {
                            prev_node = node;
                        }
                        node = ds_list_find_value(other.beam_nodes,i);
                        
                        if(instance_exists(prev_node) && instance_exists(node))
                        {
                            prev_node_x = minimap_view_left + floor(prev_node.x/32 * mini_block_size) - floor(__view_get( e__VW.XView, my_camera.view )/32)*mini_block_size;
                            prev_node_y = minimap_view_top + floor(prev_node.y/32 * mini_block_size) - floor(__view_get( e__VW.YView, my_camera.view )/32)*mini_block_size;
                                            
                            node_x = minimap_view_left + floor(node.x/32 * mini_block_size) - floor(__view_get( e__VW.XView, my_camera.view )/32)*mini_block_size;
                            node_y = minimap_view_top + floor(node.y/32 * mini_block_size) - floor(__view_get( e__VW.YView, my_camera.view )/32)*mini_block_size;
                            
                            prev_node_x = clamp(prev_node_x,minimap_left,minimap_right);
                            prev_node_y = clamp(prev_node_y,minimap_top,minimap_bottom);
                            node_x = clamp(node_x,minimap_left,minimap_right);
                            node_y = clamp(node_y,minimap_top,minimap_bottom);
        
                            draw_set_alpha(map_alpha/2);                    
                            draw_line_width(prev_node_x,prev_node_y,node_x,node_y,3);
                            draw_set_alpha(map_alpha);
                            draw_line(prev_node_x,prev_node_y,node_x,node_y);
                        }
                    }
                }
            }
        }
    }
    
    // PLAYERS
    if(instance_exists(match_obj))
    {
        my_draw_set_font(mini_font);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
    
        for(i=1; i<=match_obj.player_count; i+=1)
        {
            draw_set_alpha(map_alpha/2);
            
            guy = noone;
            
            player = ds_map_find_value(match_obj.players,i);
            if(instance_exists(player) && player.object_index == player_obj)
            {
                spawner = player.my_spawner;
                if(instance_exists(spawner))
                {
                    guy = spawner.my_guy;
                }
            }
            
            if(instance_exists(guy))
            {        
                /*
                minimap_player_view_left = minimap_view_left
                                           + floor(view_xview[i]/32 * mini_block_size)
                                           - floor(view_xview[my_camera.view]/32)* mini_block_size;
                minimap_player_view_top = minimap_view_top
                                           + floor(view_yview[i]/32 * mini_block_size)
                                           - floor(view_yview[my_camera.view]/32)* mini_block_size;
        
                minimap_player_view_right = minimap_player_view_left + minimap_view_width/2;
                minimap_player_view_bottom = minimap_player_view_top + minimap_view_height - floor(singleton_obj.player_panel_height/32) * mini_block_size;
                */
        
                minimap_player_x = minimap_view_left + floor( (guy.x-6)/(32/mini_block_size) )
                                                         - floor(__view_get( e__VW.XView, my_camera.view )/32) * mini_block_size;
                minimap_player_y = minimap_view_top + floor( (guy.y-18)/(32/mini_block_size) )
                                                         - floor(__view_get( e__VW.YView, my_camera.view )/32) * mini_block_size;
                /*
                draw_set_color(c_white);            
                if(instance_exists(guy.my_shield))
                {
                    draw_set_color(guy.my_shield.tint);
                }
                draw_rectangle(minimap_player_view_left, minimap_player_view_top,
                minimap_player_view_right, minimap_player_view_bottom, true);
                */
                            
                var number_box_size = 12,
                    number_box_xoffset = 0,
                    number_box_yoffset = -12,
                    number_box_margin = 1,
                    temp_margin = number_box_margin;
                    temp_offset = -1;
                
                if(minimap_player_x >= minimap_left 
                && minimap_player_x <= minimap_right - (mini_block_size-1)
                && minimap_player_y >= minimap_top 
                && minimap_player_y <= minimap_bottom - (mini_block_size-1))
                {
                                        
                    /*
                    draw_set_color(c_black);
                    
                    repeat(2)
                    {
                        draw_rectangle( minimap_player_x + number_box_xoffset - ceil(number_box_size/2 - temp_margin) -1,
                                        minimap_player_y + number_box_yoffset - ceil(number_box_size/2 - temp_margin),
                                        minimap_player_x + number_box_xoffset + ceil(number_box_size/2 - temp_margin) -1,
                                        minimap_player_y + number_box_yoffset + ceil(number_box_size/2 - temp_margin),
                                        false);
                        
                        draw_set_color(c_white);
                        temp_margin = 0;
                    }
                    
                    draw_set_color(c_white);
                    
                    repeat(2)
                    {
                        my_draw_text(minimap_player_x + number_box_xoffset + temp_offset,
                                  minimap_player_y + number_box_yoffset + temp_offset, string(guy.player));
                        temp_offset = 1; 
                    }
                    */
                    /*
                    draw_set_alpha(map_alpha);
                    draw_set_color(c_red);
                    
                    my_draw_text(minimap_player_x + number_box_xoffset-3,
                              minimap_player_y + number_box_yoffset,
                              string(guy.player)); 
                    */ 
                    /*   
                    draw_set_alpha(map_alpha/3);
                    draw_set_color(c_white);
                    temp_margin = 0;
                    
                    draw_rectangle( minimap_player_x - ceil(number_box_size/2 - temp_margin) -1,
                                    minimap_player_y - ceil(number_box_size/2 - temp_margin),
                                    minimap_player_x + ceil(number_box_size/2 - temp_margin) -1,
                                    minimap_player_y + ceil(number_box_size/2 - temp_margin),
                                    false);*/
                    if(floor(singleton_obj.step_count/player_blink_interval) mod 4 != 0)
                    {                
                        draw_sprite_ext(minimap_guy_spr,0,minimap_player_x,minimap_player_y,1,1,0,c_white,1);
                    }
                     
                }
            }
        }
    }
}


/* */
/*  */
