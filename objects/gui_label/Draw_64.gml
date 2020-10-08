if(!centered)
{
    if(self.text != "")
    {
        my_draw_set_font(self.font);
        var w;
        
        if(multiline)
        {
            w = string_width_ext(self.text, line_separation, width);
        }
        else
        {
            w = string_width(self.text);
        }
        
        if(width < w)
        {
            width = w+16;
        }
    }
    
    if(align == "center")
    {
        var x_diff = -width/2;
        var y_diff = -height/2;
        x += x_diff;
        y += y_diff;
        
        if(rel_position == "relative")
        {
            rel_x += x_diff;
            rel_y += y_diff;
        }
    }
    
    centered = true;
}

draw_set_alpha(self.border_alpha);
if(self.draw_thick_border)
{
    draw_set_color(self.border_color);
    if(round_corners)
    {
        draw_roundrect(x - thick_border_size, y - thick_border_size,
                       x + self.width + thick_border_size, y + self.height + thick_border_size, false);
    }
    else
    {
        draw_rectangle(x - thick_border_size, y - thick_border_size,
                       x + self.width + thick_border_size, y + self.height + thick_border_size, false);
    }
}

draw_set_alpha(bg_alpha);
if(self.draw_bg_color)
{
    draw_set_color(self.bg_color);
    if(round_corners)
    {
        draw_roundrect(x,y,x+self.width,y+self.height,false);
    }
    else
    {
        draw_rectangle(x,y,x+self.width,y+self.height,false);
    }
}
draw_set_alpha(self.border_alpha);
if(self.draw_border)
{
    draw_set_color(self.border_color);
    if(round_corners)
    {
        draw_roundrect(x,y,x+self.width,y+self.height,true);
    }
    else
    {
        draw_rectangle(x,y,x+self.width,y+self.height,true);
    }
}
draw_set_alpha(1);
my_draw_set_font(self.font);
if(text_align == "center")
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
}
else if(text_align == "left")
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
}
else if(text_align == "lefttop")
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if(depressed == true)
{
    depressed_offset = depressed_dir;
    image_index = 1;
}
else
{
    depressed_offset = 0;
    image_index = 0;
}

if(enabled)
{
    icon_color = enabled_icon_color;
    if(focused && !depressed && !locked)
    {
        icon_color = highlighted_icon_color;   
    }
}   
else
{
    icon_color = disabled_icon_color;
}

center_x = x + self.width/2 + depressed_offset;
center_y = y + self.height/2 + depressed_offset;

if(text_align == "center")
{
    text_x = center_x;
    text_y = center_y;
}
else if(text_align == "left")
{
    text_x = x+4 + depressed_offset;
    text_y = center_y;
}
else if(text_align == "lefttop")
{
    text_x = x+4 + depressed_offset;
    text_y = y+4 + depressed_offset;
}

var disp_text = self.text;
if(self.sub_text != "")
{
    disp_text += " (" + self.sub_text + ")";
}
if(show_prompt && self.text != self.prompt_str)
{
    disp_text = self.prompt_str + disp_text;   
}

draw_set_color(self.text_color);
if(icon == noone)
{
    if(multiline)
    {
        my_draw_text_ext(text_x,text_y, disp_text, line_separation, width-16);
    }
    else
    {
        my_draw_text(text_x,text_y, disp_text);
    }
}
else
{
    if(show_icon)
    {
        if(center_icon)
        {
            str_width = string_width(disp_text);
            draw_sprite_ext(icon, image_index,
                            center_x - str_width/2 - sprite_get_width(icon)/2 + sprite_get_xoffset(icon) +1,
                            center_y - sprite_get_height(icon)/2 + sprite_get_yoffset(icon) +1,
                            1,1,0, icon_color,icon_alpha);
        }
        else
        {
            draw_sprite_ext(icon,image_index,x+depressed_offset+1,y+depressed_offset+1,1,1,0,icon_color,icon_alpha);
        }
    }
    
    if(multiline)
    {
        my_draw_text_ext(text_x+16, text_y, disp_text, line_separation, width-48);
    }
    else
    {
        my_draw_text(text_x+16, text_y, disp_text);
    }
}                                                    

