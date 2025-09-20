/// @description MESSAGES, SIZE, POSITION UPDATE

// MESSAGES CROPPING AND FADING
last_msg_count = msg_count;
msg_count = ds_list_size(msg_list);
var resize = false;

if (msg_count != last_msg_count)
{
    fade_ratio = 6;
    resize = true;
}

if (msg_count > msg_max)
{
    var msg_item = msg_list[| 0];
    
    if (!is_string(msg_item) && instance_exists(msg_item))
    {
        with(msg_item)
        {
            instance_destroy();
        }
    }
    
    ds_list_delete(msg_list, 0);
    
    msg_count -= 1;
    resize = true;
}

if (fade_ratio > fade_speed)
{
    fade_ratio -= fade_speed;
}
else
{
    fade_ratio = 0;
    for (var i=0; i < msg_count; i+=1)
    {
        var msg_item = msg_list[| i];
        
        if (!is_string(msg_item) && instance_exists(msg_item))
        {
            with(msg_item)
            {
                instance_destroy();
            }
        }
    }
    
    ds_list_clear(msg_list);
    msg_count = 0;
}

//height = msg_count*msg_height + (msg_count + 1)*content_spacing;
bg_alpha = min(1,fade_ratio);
border_alpha = bg_alpha;


// SIZE AND POSITION UPDATE
if (resize)
{
    my_draw_set_font(msg_font);
    width = 0;
    for (var i = 0; i < msg_count; i+=1)
    {
        var msg_item = msg_list[| i];
        var item_width = 0;
        
        if (is_string(msg_item))
        {
            item_width = string_width(msg_item);
        }
        else if (instance_exists(msg_item))
        {
            for (var ii=0; ii < msg_item.content_length; ii++)
            {
                if (msg_item.type[? ii] == "text")
                {
                    item_width += string_width(msg_item.content[? ii]);
                }
                else if (msg_item.type[? ii] == "icon")
                {
                    item_width += sprite_get_width(msg_item.content[? ii]);
                }
                
                if (msg_item.type[? ii] != "blank" && ii < msg_item.content_length-1)
                {
                    item_width += self.content_spacing;
                }
            }
            
            msg_item.width = item_width;
        }
        
        width = max(width-2*content_spacing, item_width) + 2*content_spacing;
    }
    
    if (my_player == gamemode_obj.environment)
    {
        if (gamemode_obj.player_count == 1 || gamemode_obj.single_cam)
        {
            x = singleton_obj.current_width*3/4 - width/2 - 16;
            y = singleton_obj.current_height -height -camera_obj.border_width -1 -msg_height -80;   
        }
        else
        {
            x = singleton_obj.current_width/2 - width/2;
            y = singleton_obj.current_height -height -camera_obj.border_width -1 -msg_height -144;
        }
    }
    else
    {
        var my_camera = my_player.my_camera;
        if (instance_exists(my_camera))
        {
            var offset_set = false;
            if (view_get_visible( my_camera.view ))
            {
                self.view_x_offset = view_get_xport( my_camera.view );
                self.view_y_offset = view_get_yport( my_camera.view );
                offset_set = true;
            }
            if (!offset_set)
            {
                self.view_x_offset = view_get_xport( 0 ) + (view_get_wport( 0 )/2)*(my_camera.view-1);
                self.view_y_offset = view_get_yport( 0 );
            }
        
            x = view_get_wport( my_camera.view )/2  - width/2 + self.view_x_offset -1;
            y = my_camera.border_width + 64 + self.view_y_offset -1;
            
            if (gamemode_obj.player_count == 1)
            {
                x = singleton_obj.current_width*3/4 - width/2 - 16;
                //y += 48; // for the time window
            }
        }
    }
}
