if(active)
{
    cell_x = floor(cursor_obj.room_x/32)*32;
    cell_y = floor(cursor_obj.room_y/32)*32;
    
    mouse_down = mouse_check_button(mb_left);
    
    if(mouse_down && !mouse_held)
    {
        if(!instance_exists(selection))
        {
            selection = instance_create(cell_x,cell_y,selection_obj);
        }
        else
        {
            selection.x = cell_x;
            selection.y = cell_y;
        }
        
        mouse_held = true;
    }
    
    if(!mouse_down && mouse_held)
    {
         mouse_held = false;
    }
    
    if(mouse_held)
    {
        selection.width = cell_x +32 - selection.x;
        selection.height = cell_y +32 - selection.y;   
    }
}



