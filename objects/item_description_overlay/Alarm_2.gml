// UPDATE FRAME
if(!instance_exists(my_player.my_camera))
{
    instance_destroy();
    exit;
}
view = my_player.my_camera.view;
max_width = view_wport[view] - 192;
//max_width = __view_get( e__VW.WPort, view ) - 192;

if(message != "")
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    my_draw_set_font(self.font);
    
    width = 256;
    height = 1000;
    
    item_halfwidth = max(sprite_get_xoffset(self.image), sprite_get_width(self.image) - sprite_get_xoffset(self.image));
    item_halfheight = max(sprite_get_yoffset(self.image), sprite_get_height(self.image) - sprite_get_yoffset(self.image));
    scaled_halfwidth = item_scale * item_halfwidth;
    scaled_halfheight = item_scale * item_halfheight;
    
    while(width <= max_width && height > (line_height*max_lines)) 
    {   
        width += 32;
        height = string_height_ext(string_hash_to_newline(message), line_height, width - 32);
    }
    text_width = width;    
    
    width += scaled_halfwidth;
    height += 64;       
    
    fadeout_step = 0;
    
    focused = true;
    
    /*
    with(item_description_overlay)
    {
        if(id != other.id && my_player == other.my_player)
        {
            close_frame(id);
        }
    }
    */
}
else
{
    width = 0;
    height = 0;     
}

side_x = __view_get( e__VW.XPort, view ) + 112;

//start_x = __view_get( e__VW.XPort, view ) + __view_get( e__VW.WPort, view )/2 - width/2;
start_x = side_x;
start_y = __view_get( e__VW.YPort, view ) + __view_get( e__VW.HPort, view )*0.35 - height/2;

x = start_x;
y = start_y;
