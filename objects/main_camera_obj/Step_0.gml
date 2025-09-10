event_inherited();

if (count > 0 && !on) //&& view_visible[0]
{
    //view_visible[0]=false;
    var total_x = 0;
    var total_y = 0;
    
    if (my_chunkgrid != noone) {
        observer_remove(my_chunkgrid, id);
    }

    for (var i = 0; i < count; i++)
    {
        var player_view = player_view_list[| i];
        var cam = cameras[? player_view];
        cam.on = true;
        if (cam.my_chunkgrid == noone) {
            observer_add(chunkgrid_obj, cam.id);
        }
        total_x += cam.x;
        total_y += cam.y;
    }
    
    x = total_x/count;
    y = total_y/count;
    
    followed_x = x;
    followed_y = y;
    
    var viewCamera = view_get_camera(view);
    camera_set_view_pos(viewCamera,
        x - camera_get_view_width(viewCamera) / 2,
        y - camera_get_view_height(viewCamera) / 2
    );

    if (ter_list_length > 0)
    {
        for (var ii = ter_list_length - 1; ii >= 0; ii--)
        {
            var ter_block = ds_list_find_value(ter_list, ii);
            if (!is_undefined(ter_block) && instance_exists(ter_block))
            {
               ter_block.visible = false;
            }
        }
        ds_list_clear(ter_list);
        ter_list_length = 0;
    }
}

if (on || count == 0) // !view_visible[0] &&
{
    //view_visible[0]=true;
    for (var i = 0; i < count; i++)
    {
        var player_view = player_view_list[| i];
        var cam = cameras[? player_view];

        with(cam)
        {
            on = false;
            
            if (ter_list_length > 0)
            {
                for (var ii = ter_list_length - 1; ii >= 0; ii--)
                {
                    var ter_block = ds_list_find_value(ter_list, ii);
                    if (!is_undefined(ter_block) && instance_exists(ter_block))
                    {
                       ter_block.visible = false;
                    }
                }
                ds_list_clear(ter_list);
                ter_list_length = 0;
            }
            
            if(my_chunkgrid != noone)
            {
                observer_remove(chunkgrid_obj, id);
            }
        }
    }
    
    if(my_chunkgrid == noone)
    {
        observer_add(chunkgrid_obj, id);
    }
}

bg_xoffset += bg_hspeed;
bg_yoffset += bg_vspeed;
