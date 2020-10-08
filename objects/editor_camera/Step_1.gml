if(on)
{
    half_wview = __view_get( e__VW.WView, view )/2;
    half_hview = __view_get( e__VW.HView, view )/2;
    
    if(pan_mode)
    {
        mouse_down = mouse_check_button(mb_left);
        
        if(mouse_down)
        {
            if(!dragging)
            {
                dragging = true;
                orig_x = x;
                orig_y = y;
                orig_mouse_x = cursor_obj.x;
                orig_mouse_y = cursor_obj.y;
            }
            else
            {
                x = orig_x - (cursor_obj.x - orig_mouse_x);
                y = orig_y - (cursor_obj.y - orig_mouse_y);
                x = max(half_wview,min(x,place_obj.x+place_obj.width +place_obj.margin -half_wview));
                y = max(half_hview,min(y,place_obj.y+place_obj.height +place_obj.margin -half_hview));       
            }    
        }
        
        if(dragging && !mouse_down)
        {
            dragging = false;
        }    
    }
    
    if(!inited_view)
    {
        inited_view = true;    
        update_display();
    }
    
    __view_set( e__VW.XView, view, x-__view_get( e__VW.WView, view )/2 ); 
    __view_set( e__VW.YView, view, y-__view_get( e__VW.HView, view )/2 );
}

