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
    
    mouse_down = mouse_check_button_pressed(mb_left);
    
    can_place = false;
    can_erase = false;
    free_space = false;
    
    if(cell_x < place_obj.x || cell_x >= place_obj.x + place_obj.width
    || cell_y < place_obj.y || cell_y >= place_obj.y + place_obj.height)
    {
        has_placed = false;    
    }
    else
    {
        nearest_ter = instance_nearest(cell_x,cell_y,editor_terrain_obj);
        
        free_cell = !(abs(nearest_ter.x - cell_x) <= structure_radius && abs(nearest_ter.y - cell_y) <= structure_radius);    
    
        nearest_struct = instance_nearest(cell_x,cell_y,editor_structure_object);
        
        free_space = !(abs(nearest_struct.x - cell_x) <= structure_radius && abs(nearest_struct.y - cell_y) <= structure_radius);
        
        if(free_cell && free_space && create && !erase)
        {
            can_place = true;
        }
        
        if(overwrite && !erase)
        {
            can_place = true;
        }
        
        if(!free_space && erase)
        {
            can_erase = true;
        }       
    }
    
    if(can_place && mouse_down && !has_placed)
    {  
        if(overwrite && !free_cell)
        {
            while(!free_cell)
            {
                with(nearest_ter)
                {
                    instance_destroy();
                }
                 
                nearest_ter = instance_nearest(cell_x,cell_y,editor_terrain_obj);   
                free_cell = !(abs(nearest_ter.x - cell_x) <= structure_radius && abs(nearest_ter.y - cell_y) <= structure_radius);
                
            }
        }
        if(overwrite && !free_space)
        {
            while(!free_space)
            {
                with(nearest_struct)
                {
                    instance_destroy();
                }
                 
                nearest_struct = instance_nearest(cell_x,cell_y,editor_structure_object);   
                free_space = !(abs(nearest_struct.x - cell_x) <= structure_radius && abs(nearest_struct.y - cell_y) <= structure_radius);
            }
        }
        if((create || overwrite) && free_cell && free_space)
        {
            switch(mode)
            {
                case 1:
                    if(instance_number(editor_guy_spawner_obj) < 2)
                    {
                        ii = instance_create(cell_x,cell_y,editor_guy_spawner_obj);
                        has_placed = true;
                    }
                break;
                
                case 2:
                    ii = instance_create(cell_x,cell_y,editor_jump_pad_obj);
                    has_placed = true;
                break;
                
                case 3:   
                    var ter = instance_nearest(cell_x,cell_y,editor_terrain_obj);
                    var dist = point_distance(ter.x,ter.y,cell_x,cell_y);
                    var dir = point_direction(ter.x,ter.y,cell_x,cell_y);
                    
                    if(dist == 32)
                    {
                        ii = instance_create(cell_x,cell_y,editor_turret_obj);
                        ii.direction = dir;
                        has_placed = true;
                    }
                break;
            }
        }
    }
    
    if(can_erase && mouse_down && !free_space)
    {
        with(nearest_struct)
        {
            instance_destroy();
        }
    }
}


