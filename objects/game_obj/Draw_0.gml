if(singleton_obj.draw_bboxes)
{
    draw_set_colour(tint+c_white/2);
    draw_set_alpha(0.5);
    draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom, false);
    draw_set_alpha(1);
}

if(read_terrain && singleton_obj.draw_ter_lists)
{
    var ii, ter_block;
    
    draw_set_color(c_white);
    
    for(ii=0; ii<ter_list_length; ii+=1)
    {
        ter_block = ds_list_find_value(ter_list,ii);
        if(instance_exists(ter_block))
        {
            draw_sprite(ter_highlight_spr,0, ter_block.x,ter_block.y);
        }
    }       
}

if((singleton_obj.draw_object_labels || self.draw_label) && !self.invisible && sprite_exists(sprite_index) && name != "")
{
    my_draw_set_font(label_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var label_height = label_scale * string_height(name) + 4;
    var label_width = label_scale * string_width(name) + 4;

    var yy = y - sprite_get_yoffset(sprite_index) - label_distance;
 
    draw_set_color(c_black);   
    draw_set_alpha(0.5 * self.label_alpha);   
    draw_rectangle(x-floor(label_width/2),yy-floor(label_height/2),x+floor(label_width/2),yy+floor(label_height/2),false);
    
    draw_set_color(c_white);
    draw_set_alpha(self.label_alpha);
    if(label_scale == 1)
    {
        my_draw_text(x,yy, name);
    }
    else
    {
        my_draw_text_transformed(x,yy, name, label_scale, label_scale, 0);
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if(singleton_obj.draw_depths)
{
    var depth_str = string(depth);
    my_draw_set_font(little_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var label_height = string_height(depth_str) + 4;
    var label_width = string_width(depth_str) + 4;
 
    draw_set_color(c_black);   
    draw_set_alpha(1);   
    draw_rectangle(x-floor(label_width/2),y-floor(label_height/2),x+floor(label_width/2),y+floor(label_height/2),false);
    
    draw_set_color(c_white);
    my_draw_text(x,y, depth_str);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}



