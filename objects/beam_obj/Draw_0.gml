// Note: "node_x" is "x" of "beam_head_node"
if(endpoint_reached && !invalid)
{
    last_node = ds_list_size(beam_nodes)-1;
    
    if(facing_right)
        facing = 1;
    else
        facing = -1;
    
    // BEAM GOES OUTSIDE ROOM
    if(!collided)
    {
        node = ds_list_find_value(beam_nodes,0);
        draw_sprite_ext(beam_start,image_index,node.x,y,facing,1,0,self.tint,image_alpha);
        
        if(beam_head_fired && !beam_head_landed)
        {
            draw_sprite_ext(beam_head,image_index,node_x+beam_head_dist,y,head_facing,1,0,self.tint,image_alpha);
        }
        
        phase_str="";
        
        //draw_line_width(node.x,y,(1+1.1*facing)*room_width/2,y,beam_width);
        
        for(ii = node.x; sign((1+1.1*facing)*room_width/2 - ii) == facing; ii += beam_speed*facing)
        {
            next_ii = ii + beam_speed*facing;  
            
            // DETECT PHASE CHANGE
            if(beam_head_fired)
            {
                if(beam_draw_phase != 0 && sign(node_x+beam_head_dist-ii) == facing)
                {
                    beam_draw_phase = 0;
                    radii_updated = false;
                }
                
                if(beam_draw_phase != 2 && sign(ii-(node_x+beam_head_dist)) == facing)
                {
                    beam_draw_phase = 2;
                    radii_updated = false;
                }    
            
                if(beam_draw_phase != 1 && sign((node_x+beam_head_dist)-ii) == facing && sign(next_ii-(node_x+beam_head_dist)) == facing)
                {
                    beam_draw_phase = 1;
                    radii_updated = false;
                }    
            }
            
            if(beam_draw_phase != 2 && !beam_head_fired)
            {
                beam_draw_phase = 2;
                radii_updated = false;
            }

            // UPDATE RADII WHEN PHASE CHANGES
            if(!radii_updated)
            {
                if(beam_draw_phase == 0)
                {
                    core_radius = beam_big_core_size/2;
                    next_core_radius = beam_big_core_size/2;
                    phase_str+="0";
                }
                
                if(beam_draw_phase == 1)
                {
                    core_radius = beam_big_core_size/2;                          
                    next_core_radius = beam_small_core_size/2;
                    phase_str+="1";
                }
                
                if(beam_draw_phase == 2)
                {
                    core_radius = beam_small_core_size/2;
                    next_core_radius = beam_small_core_size/2;
                    phase_str+="2";
                }
                
                beam_radius = core_radius + beam_glow_size;
                next_beam_radius = next_core_radius + beam_glow_size;
                radii_updated = true;
            }
            
            // SETUP BEAM PART DRAWING                  
            highlight = false;
        
            repeat(2)
            {
                if(highlight)
                {
                    draw_set_color(c_white);
                    draw_set_alpha(beam_alpha*beam_highlight_ratio);
                    draw_primitive_begin_texture(pr_trianglelist,beam_high_tex);
                    highlight = false;
                }
                else
                {
                    draw_set_color(self.tint);
                    draw_set_alpha(beam_alpha);
                    draw_primitive_begin_texture(pr_trianglelist,beam_tex);
                    highlight = true;
                }
                
                flip = 1;
    
                // DRAW CORE TRIANGLES
                
                repeat(2)
                {
                    draw_vertex_texture(ii,y-core_radius*flip,0,beam_tex_glow_end);
                    repeat(2)
                    {
                        draw_vertex_texture(ii,y,0,1);
                        draw_vertex_texture(next_ii,y-next_core_radius*flip,1,beam_tex_glow_end);
                    }
                    draw_vertex_texture(next_ii,y,1,1);
                    flip *= -1;
                }
                
                // DRAW GLOW TRIANGLES
                
                repeat(2)
                {
                    draw_vertex_texture(ii,y-beam_radius*flip,0,beam_tex_glow_start);
                    repeat(2)
                    {
                        draw_vertex_texture(ii,y-core_radius*flip,0,beam_tex_glow_end);
                        draw_vertex_texture(next_ii,y-next_beam_radius*flip,1,beam_tex_glow_start);
                    }
                    draw_vertex_texture(next_ii,y-next_core_radius*flip,1,beam_tex_glow_end);
                    flip *= -1;
                }
                
                draw_primitive_end();  
            } 
        }
        
        draw_sprite_ext(beam_start_highlight,image_index,node.x,y,facing,1,0,c_white,image_alpha*beam_highlight_ratio);
        
        if(beam_head_fired && !beam_head_landed)
        {
            draw_sprite_ext(beam_head_highlight,image_index,node_x+beam_head_dist,y,head_facing,1,0,c_white,image_alpha*beam_highlight_ratio);
        }
        //show_debug_message("phases: "+phase_str);
    }
    
    //BEAM HITS SOMETHING    
    else
    {   
        node_fix = 0;
        next_node_fix = 0;
        for(i=0;i<=last_node;i+=1)
        {
            node = ds_list_find_value(beam_nodes,i);
            
            if(i != 0)
            {
                node_fix = next_node_fix;
            }
            
            
            
            if(i <= last_node-1)
            {
                next_node = ds_list_find_value(beam_nodes,i+1);
        
                if(!(instance_exists(node) && instance_exists(next_node)))
                {
                    break;
                }
                
                if(object_is_ancestor(next_node.object_index,terrain_obj))
                    next_node_fix = 16 - facing*16;
                if(next_node.object_index == shield_obj)
                    next_node_fix = -facing*20;
                    
                // DRAW START SPRITE
                if(i == 0)
                {
                    draw_sprite_ext(beam_start,image_index,node.x,y,facing,1,0,self.tint,image_alpha);
                }
                
                // DRAW END SPRITE
                if(i == last_node-1)
                {        
                    draw_sprite_ext(beam_end_sprite,image_index,next_node.x+next_node_fix,y,facing,1,0,self.tint,image_alpha);
                }
                
                // DRAW HEAD SPRITE
                if(beam_head_fired && !beam_head_landed)
                {
                    draw_sprite_ext(beam_head,image_index,node_x+beam_head_dist,y,head_facing,1,0,self.tint,image_alpha);
                }
                    
                phase_str="";

                //draw_line_width(node.x+node_fix,y,next_node.x+next_node_fix,y,beam_width);
                
                for(ii = node.x+node_fix; sign((next_node.x+next_node_fix)-ii) == facing; ii += beam_speed*facing)
                {
                    if(abs(ii-(next_node.x + next_node_fix)) <= beam_speed)
                    {
                        next_ii = next_node.x + next_node_fix;
                    }
                    else
                    {
                        next_ii = ii+beam_speed*facing;
                    }
                    
                    
                    // DETECT PHASE CHANGE
                    if(beam_head_fired)
                    {
                        if(beam_draw_phase != 0 && (i < beam_head_node || (i == beam_head_node && sign(node_x+beam_head_dist-(ii-node_fix)) == facing)))
                        {
                            beam_draw_phase = 0;
                            radii_updated = false;
                        }
                        
                        if(beam_draw_phase != 2 && (i > beam_head_node || (i == beam_head_node && sign((ii-node_fix)-(node_x+beam_head_dist)) == facing)))
                        {
                            beam_draw_phase = 2;
                            radii_updated = false;
                        }    
                    
                        if(beam_draw_phase != 1 && i == beam_head_node && sign((node_x+beam_head_dist)-(ii-node_fix)) == facing && sign((next_ii-node_fix)-(node_x+beam_head_dist)) == facing)
                        {
                            beam_draw_phase = 1;
                            radii_updated = false;
                        }
                    }
                        
                    if(beam_draw_phase != 2 && !beam_head_fired)
                    {
                        beam_draw_phase = 2;
                        radii_updated = false;
                    }
                    
                    if(beam_draw_phase != 0 && beam_head_landed)
                    {
                        beam_draw_phase = 0;
                        radii_updated = false;
                    }  
                    
                    // UPDATE RADII WHEN PHASE CHANGES
                    if(!radii_updated)
                    {
                        if(beam_draw_phase == 0)
                        {
                            core_radius = beam_big_core_size/2;
                            next_core_radius = beam_big_core_size/2;
                            phase_str+="0";
                        }
                        
                        if(beam_draw_phase == 1)
                        {
                            core_radius = beam_big_core_size/2;                          
                            next_core_radius = beam_small_core_size/2;
                            phase_str+="1";
                        }
                        
                        if(beam_draw_phase == 2)
                        {
                            core_radius = beam_small_core_size/2;
                            next_core_radius = beam_small_core_size/2;
                            phase_str+="2";
                        }
                        
                        beam_radius = core_radius + beam_glow_size;
                        next_beam_radius = next_core_radius + beam_glow_size;
                        radii_updated = true;
                    }

                    // SETUP BEAM PART DRAWING                  
                    highlight = false;
                    
                    repeat(2)
                    {
                        if(!highlight)
                        {
                            draw_set_color(self.tint);
                            draw_set_alpha(beam_alpha);
                            draw_primitive_begin_texture(pr_trianglelist,beam_tex);
                            highlight = true;
                        }
                        else
                        {
                            draw_set_color(c_white);
                            draw_set_alpha(beam_alpha*beam_highlight_ratio);
                            draw_primitive_begin_texture(pr_trianglelist,beam_high_tex);
                            highlight = false;
                        }
                        
                        flip = 1;
                    
                        // DRAW CORE TRIANGLES
                        
                        repeat(2)
                        {
                            draw_vertex_texture(ii,y-core_radius*flip,0,beam_tex_glow_end);
                            repeat(2)
                            {
                                draw_vertex_texture(ii,y,0,1);
                                draw_vertex_texture(next_ii,y-next_core_radius*flip,1,beam_tex_glow_end);
                            }
                            draw_vertex_texture(next_ii,y,1,1);
                            flip *= -1;
                        }
                        
                        flip = 1;
                        
                        // DRAW GLOW TRIANGLES
                        
                        repeat(2)
                        {
                            draw_vertex_texture(ii,y-beam_radius*flip,0,beam_tex_glow_start);
                            repeat(2)
                            {
                                draw_vertex_texture(ii,y-core_radius*flip,0,beam_tex_glow_end);
                                draw_vertex_texture(next_ii,y-next_beam_radius*flip,1,beam_tex_glow_start);
                            }
                            draw_vertex_texture(next_ii,y-next_core_radius*flip,1,beam_tex_glow_end);
                            flip *= -1;
                        }
                           
                        draw_primitive_end();        
                    }
                }
                
                //show_debug_message("phases: "+phase_str);

                // HIGHLIGHTS
                    
                // DRAW START SPRITE
                if(i == 0)
                {
                    draw_sprite_ext(beam_start_highlight,image_index,node.x,y,facing,1,0,c_white,image_alpha*beam_highlight_ratio);
                }
                
                // DRAW END SPRITE
                if(i == last_node-1)
                {        
                    draw_sprite_ext(beam_end_highlight,image_index,next_node.x+next_node_fix,y,facing,1,0,c_white,image_alpha*beam_highlight_ratio);
                }
                
                // DRAW HEAD SPRITE
                if(beam_head_fired && !beam_head_landed)
                {
                    draw_sprite_ext(beam_head_highlight,image_index,node_x+beam_head_dist,y,head_facing,1,0,c_white,image_alpha*beam_highlight_ratio);
                }
            }
            
            facing *= -1;
        }
    }
    draw_set_alpha(1);
}

action_inherited();
