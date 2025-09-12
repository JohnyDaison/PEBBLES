/// @description  ADJUST WIDTH TO MESSAGE
if (message != "" && !adjusted)
{
    my_draw_set_font(big_font);
    width = string_width(string_hash_to_newline(message))+96;
    height = string_height(string_hash_to_newline(message))+64;
    x = view_get_wport( 0 )/2 - width/2;
    y = view_get_hport( 0 )/2 - height/2;
    adjusted = true;
    draw_border = true;
    draw_bg_color = true;
}

if (message=="")
{
    draw_border = false;
    draw_bg_color = false;
}


event_inherited();

/// DRAW MESSAGE
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (message != "")
{
    my_draw_set_font(big_font);
    draw_set_color(c_ltgray - self.color);
    
    var i=2;
    repeat(2)
    {
        my_draw_text(x+width/2+i,y+height/2+i,string_hash_to_newline(message));
        
        draw_set_color(self.color);
        i=0;
    }
}

if (is_string(tip) && tip != "")
{
    var tip_margin = 4;
    draw_set_color(bg_color);
    draw_set_alpha(bg_alpha);
    draw_roundrect(x + tip_margin, y+height +tip_offset-floor(tip_height/2) +tip_margin,
                        x + width - tip_margin -1, y + height +tip_offset+ceil(tip_height/2) - tip_margin -1, false);
    
    draw_set_alpha(1);
    my_draw_set_font(window_font);
    draw_set_color(c_ltgray - self.color);
    var i=2;
    repeat(2)
    {
        my_draw_text(x+width/2+i,y+height+tip_offset+i,string_hash_to_newline("Tip: "+tip));
        
        draw_set_color(self.color);
        i=0;
    }
}

// debug
/*
my_draw_set_font(big_font);
draw_set_color(c_white);
my_draw_text(x+width/2, y-height, string(singleton_obj.step_count));
*/
