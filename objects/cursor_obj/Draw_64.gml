    /// @description  CURSOR, TOOLTIP
draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,1);
draw_sprite_ext(sprite_index,1,x,y,1,1,0,self.tint,glow_ratio);
draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,0.2);

if(active_tool != noone)
{
    draw_sprite_ext(target_cross,0,x,y,1,1,0,c_white,1);   
}

if(tooltip != "")
{
    my_draw_set_font(label_font);
    draw_set_color(self.tint);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    
    var text = string_hash_to_newline(tooltip);
    var tip_x = x + 8;
    var tip_y = y - 8;
    
    draw_set_color(tooltip_bg_color);
    var width = string_width(text);
    draw_roundrect(tip_x - 4, tip_y - 26, tip_x + width, tip_y + 2, false);
    
    draw_set_color(c_gray - self.tooltip_color);
    i = -1;
    repeat(2)
    {
        my_draw_text(tip_x+i, tip_y+i, text);
        i = 1;
    }
    draw_set_color(self.tooltip_color);
    my_draw_text(tip_x, tip_y, text);
}

/// DISABLED
if(keyboard_check(vk_alt) && false)
{
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_src_alpha_sat);
    draw_rectangle(x-33,y-100,x+100,y+100,false);
    draw_set_blend_mode(bm_normal);
}