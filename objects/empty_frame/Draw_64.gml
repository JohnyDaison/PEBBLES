/// @description  DRAW FRAME 

if(keep_inside)
{
    if(instance_exists(main_camera_obj))
    {
        border_width = main_camera_obj.border_width;
    }
    else
    {
        border_width = 0;
    }
    
    if(x < border_width)
    {
        x = border_width;
    }
    if(x > singleton_obj.current_width - width - border_width)
    {
        x = singleton_obj.current_width - width - border_width;
    }
    if(y < border_width)
    {
        y = border_width;
    }
    if(y > singleton_obj.current_height - height - border_width)
    {
        y = singleton_obj.current_height - height - border_width;
    }
}

//offset_x = x+self.view_x_offset;
//offset_y = y+self.view_y_offset;
window_axis = x+self.width/2;

if(focused || nonfocusable)
{
    focus_modifier = 1;
}
else
{
    focus_modifier = 0.5;
}

// BG
draw_set_alpha(self.alpha*self.bg_alpha*focus_modifier);
if(self.draw_bg_color)
{
    draw_set_color(self.bg_color);
    draw_roundrect(x,y,x+self.width,y+self.height,false);
}

// BORDER
draw_set_alpha(self.alpha*self.border_alpha*focus_modifier);
if(self.draw_border)
{
    draw_set_color(self.border_color);
    //draw_set_blend_mode(bm_subtract); 
    draw_roundrect(x,y,x+self.width,y+self.height,true);
    //draw_set_blend_mode(bm_normal);
    if(self.focused && self.content_focused == -1)
    {
        draw_set_color(self.border_highlight_color);
        //draw_set_blend_mode(bm_subtract); 
        draw_roundrect(x,y,x+self.width,y+self.height,true);
    }
}

// HEADING
if(self.draw_heading)
{
    draw_set_alpha(self.alpha*1*focus_modifier);
    draw_set_color(self.color);
    my_draw_set_font(self.font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    my_draw_text(window_axis, y+heading_offset, self.text);
}

// debug

//draw_text(x+100, y+100, string(depth));