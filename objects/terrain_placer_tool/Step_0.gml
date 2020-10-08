if(active)
{
    last_cell_x = cell_x;
    last_cell_y = cell_y;
    cell_x = floor(cursor_obj.room_x/32)*32;
    cell_y = floor(cursor_obj.room_y/32)*32;
    
    if(last_cell_x != cell_x || last_cell_y != cell_y)
    {
        has_placed = false;
    }   
    
    mouse_down = mouse_check_button(mb_left);
    
    can_place = false;
    can_erase = false;
    
    if(cell_x < place_obj.x || cell_x >= place_obj.x + place_obj.width
    || cell_y < place_obj.y || cell_y >= place_obj.y + place_obj.height)
    {
        has_placed = false;    
    }
    else
    {
        nearest_ter = instance_nearest(cell_x,cell_y,editor_terrain_obj);
        
        free_cell = !(nearest_ter.x == cell_x && nearest_ter.y == cell_y);
        
        nearest_struct = instance_nearest(cell_x,cell_y,editor_structure_object);
        
        free_space = !(abs(nearest_struct.x - cell_x) <= 32 && abs(nearest_struct.y - cell_y) <= 32);
        
        if(free_cell && free_space && create && !erase)
        {
            can_place = true;
        }
        
        if(!free_cell && free_space && overwrite && !erase)
        {
            can_place = true;
        }
        
        if(!free_cell && erase)
        {
            can_erase = true;
        }       
    }
    
    if(can_place && mouse_down && !has_placed)
    {
        if(create && free_cell)
        {
            ii = instance_create(cell_x,cell_y,editor_terrain_obj);
            ii.palette_index = palette_index;
            with(ii)
            {
                event_perform(ev_other,ev_user0);
            }
        }
        if(overwrite && !free_cell)
        {
            ii = nearest_ter;
            ii.palette_index = palette_index;
            with(ii)
            {
                event_perform(ev_other,ev_user0);
            }
        }
        has_placed = true;
    }
    
    if(can_erase && mouse_down && !free_cell)
    {
        with(nearest_ter)
        {
            instance_destroy();
        }
    }
}


