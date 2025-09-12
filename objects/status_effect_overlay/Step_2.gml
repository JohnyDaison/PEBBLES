event_inherited();

// TODO: Why does this with() exist?
with (status_effect_overlay) {
/// INIT and STEP
if(!ready)
{
    if(instance_exists(my_player) && instance_exists(my_guy) && view_enabled)
    {
        if(instance_exists(my_player.my_camera))
        {
            my_camera = my_player.my_camera;

            var offset_set = false;
            if(view_get_visible( my_camera.view ))
            {
                self.view_x_offset = view_get_xport( my_camera.view );
                self.view_y_offset = view_get_yport( my_camera.view );
                offset_set = true;
            }
            if(!offset_set)
            {
                self.view_x_offset = view_get_xport( 0 ) + (view_get_wport( 0 )/2)*(my_camera.view-1);
                self.view_y_offset = view_get_yport( 0 );
            }
            
           ready = true;
        }
    }
}

if(ready && instance_exists(my_guy))
{ 
    // UPDATE VALUES
    
    // POSITIONS
    x = view_get_wport( my_camera.view ) - my_camera.border_width + self.view_x_offset;
    y = my_camera.border_width + 256 + self.view_y_offset;

    // EFFECTS  
    for(var i = 0; i < DB.status_effect_count; i++)
    {
        var effect_id = status_list[| i];
        var effect = DB.status_effects[? effect_id];
        var effect_left = my_guy.status_left[? effect_id];
        var index = ds_list_find_index(status_order, effect_id);
        
        if(effect_left > 0 && DB.color_effects[? effect.color] != effect)
        {
            if(index == -1)
            {
                ds_list_add(status_order, effect_id);
                status_alpha[? effect_id] = 1;
            }
            else
            {
                if(status_alpha[? effect_id] < 0.5)
                {
                    status_alpha[? effect_id] += status_fade_rate;
                }
                else
                {
                    status_alpha[? effect_id] = 1;
                }
            }
        }
        else
        {
            if(index >= 0)
            {
                status_alpha[? effect_id] -= status_fade_rate;
                
                if(status_alpha[? effect_id] < 0)
                {
                    ds_list_delete(status_order, index);
                }
            }
        }
    }
}

}
