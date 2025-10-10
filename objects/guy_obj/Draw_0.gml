// PROTECTED BLINKING AND DRAW SPRITE

blink_off = self.protected && (self.at_rest || !self.lost_control) && round(self.step_count/blink_rate) mod 2 == 0;

if(!blink_off)
{
    //glow_alpha = 0.2 + 0.4*dmg_ratio;
    //alpha = 0.2 + 0.7*dmg_ratio;
    /*
    if(my_color != g_dark)
    {
        draw_sprite_ext(sprite_index,image_index,x,y-size_pulse*24-2,facing*(1+size_pulse)*1.3,(1+size_pulse)*1.025,0,merge_color(c_white,self.tint,0.25),glow_alpha);
    }
    */
    //draw_sprite_ext(sprite_index,image_index,x,y-size_pulse*24,facing*(1+size_pulse),1+size_pulse,0,self.tint,alpha);
    /*if(!is_glitching)
    {*/
        draw_sprite_ext(sprite_index,image_index,x,y,facing,1,0,self.tint,alpha*self.holo_alpha);
    /*}
    else
    {  
        draw_sprite_ext(sprite_index,image_index,x,y,facing,1,0,self.tint,alpha/2);
        draw_sprite_ext(sprite_index,image_index,x+glitch_x_offset,y+glitch_y_offset,facing,1,0,self.tint,alpha/2);
        draw_sprite_ext(sprite_index,image_index,x-glitch_x_offset,y-glitch_y_offset,facing,1,0,self.tint,alpha/2);
    }*/
}

/*
state[0] = x;
state[1] = y;
state[2] = sprite_index;
state[3] = image_index;
state[4] = self.tint;
state[5] = self.facing_right;
*/

// HASTE PHANTOMS

if(self.has_haste)
{
    stepnum = 4;
    fanthoms = 3;
    max_step = stepnum*(fanthoms+1);
    queue_size = ds_list_size(self.flashback_queue);
    for(i = stepnum; i < max_step; i += stepnum)
    {
        old_state_str = ds_list_find_value(self.flashback_queue,queue_size-i);
        if(is_string(old_state_str))
        {
            ds_map_read(old_state,old_state_str);
            if(ds_map_size(old_state)!=0)
            {
                old_spri = ds_map_find_value(old_state,"sprite_index");
                old_imgi = ds_map_find_value(old_state,"image_index");
                old_x = ds_map_find_value(old_state,"x"); 
                old_y = ds_map_find_value(old_state,"y"); //  - size_pulse*24
                old_facing = ds_map_find_value(old_state,"facing")*(1); //+size_pulse
                old_tint = ds_map_find_value(old_state,"tint");
                
                step_alpha_ratio = 1 - i/max_step;
                    
                if(old_tint != ds_map_find_value(DB.colormap,g_dark))
                {
                    //draw_sprite_ext(old_spri,old_imgi, old_x,old_y-2,old_facing*1.3,(1+size_pulse)*1.025,0,merge_color(c_white,old_tint,0.25),step_alpha_ratio*glow_alpha);
                }
                
                draw_sprite_ext(old_spri,old_imgi, old_x,old_y, old_facing, 1,0,old_tint,step_alpha_ratio*alpha); // +size_pulse
            }
            else
                show_debug_message("old state is empty");
        }
        else
            show_debug_message("old state str is not string");
    }
}

// FLASHBACK

if(self.flashing_back)
{
    stepnum = 1;
    fanthoms = ds_list_size(self.flashback_queue);
    max_step = stepnum*fanthoms;
    for(i=stepnum;i<=max_step;i+=stepnum)
    {
        ds_map_read(old_state,(self.flashback_queue[| fanthoms-i]));
        if(ds_map_size(old_state)!=0)
        {
            fb_alpha = alpha - i*time_rate/max_step;
            
            if(fb_alpha<0)
                fb_alpha = 0;
            
            draw_sprite_ext(ds_map_find_value(old_state,"sprite_index"),
                            ds_map_find_value(old_state,"image_index"),
                            ds_map_find_value(old_state,"x"),
                            ds_map_find_value(old_state,"y"), // -size_pulse*24
                            ds_map_find_value(old_state,"facing")*(1), //+size_pulse
                            1,0, // +size_pulse
                            ds_map_find_value(old_state,"tint"),fb_alpha);
        }
        else
            show_debug_message("old state is empty");
    }
}

// JUMPING ORBS

if(jumping_charge > 0)
{
    var cur_max_dist = 24*(jumping_max_charge/jumping_normal_charge);
    var cur_ratio = jumping_charge/jumping_max_charge;
    var cur_dist = cur_max_dist*(1-cur_ratio);
    
    draw_sprite_ext(jump_orb_spr,0,x-cur_dist,y+24,1,1,0,c_white,cur_ratio);
    
    draw_sprite_ext(jump_orb_spr,0,x+cur_dist,y+24,1,1,0,c_white,cur_ratio);
}

// npc debug
/*
if(is_npc)
{  
    my_draw_text(x-16,y-96,string(npc_active));
    my_draw_text(x+16,y-96,string(slot_number));
    my_draw_text(x-16,y-80,string(phase));
    my_draw_text(x+16,y-80,string(have_jumped));
}
*/

// status effect debug
/*
my_draw_text(x-32,y-48,string(burn_left));
my_draw_text(x,y-48,string(frozen_left));
my_draw_text(x+32,y-48,string(slow_left));
*/

// color charge debug
/*
my_draw_text(x-32,y-48,string(color_charge[? g_red]));
my_draw_text(x,y-48,string(color_charge[? g_green]));
my_draw_text(x+32,y-48,string(color_charge[? g_blue]));
*/

// duration_coef debug
//my_draw_text(x+64, y+64, string(channel_duration));

// orb pickup debug
/*
with(color_orb_obj)
{
    if(!collected) {
        draw_set_colour(c_black);    
        draw_line_width(bbox_left, bbox_top, other.bbox_left, other.bbox_top,3);
        draw_rectangle(bbox_left-1, bbox_top-1, bbox_right-1, bbox_bottom-1, true);
        draw_rectangle(bbox_left+1, bbox_top+1, bbox_right+1, bbox_bottom+1, true);
        
        draw_set_colour(c_orange);
        draw_line(bbox_left, bbox_top, other.bbox_left, other.bbox_top);
        draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    }
}
*/

if(DB.console_mode == CONSOLE_MODE.DEBUG)
{
    var count = ds_list_size(attack_waypoints), i, wp;
    draw_set_color(c_red);

    for(i=0; i < count; i++)
    {
        wp = attack_waypoints[| i];
        if(instance_exists(wp))
        {
            draw_line_width(x, y, wp.x, wp.y, 3);
        }
    }
}

event_inherited();
