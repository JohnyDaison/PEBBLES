if(invisible)
    visible = false;
// TINT UPDATE

if(!tint_updated)
{
    if(multicolor)
    {
        if(my_color == g_octarine)
        {
            if(octarine_phase_shift == 0)
            {
                tint = singleton_obj.octarine_tint;
            }
            else
            {
                tint = make_colour_hsv((singleton_obj.step_count*4 + octarine_phase_shift) mod 256, 196, 255);
            }
            
            if(damage_tint_alpha > 0)
            {
                tint = merge_colour(tint, last_damage_tint, damage_tint_alpha);
                damage_tint_alpha = max(0, damage_tint_alpha - damage_tint_fade_step);
            }
        }
        else
        {
            new_tint = DB.colormap[? my_color];
            
            var old = tint;
            tint = merge_colour(tint, new_tint, 1/6);
            
            if(old == tint)
            {
                tint = new_tint;
            }
            
            if(tint == new_tint)
            {
                tint_updated = true;
            }
        }  
    }
    else
    {
        tint = forced_tint;
    }
}

// HOLOGRAPHIC
if(holographic)
{
    holo_alpha += holo_alpha_step;
    
    if(holo_alpha < holo_minalpha)
    {
        holo_alpha = holo_minalpha;
        holo_alpha_step *= -1;
    }
    
    if(holo_alpha > holo_maxalpha)
    {
        holo_alpha = holo_maxalpha;
        holo_alpha_step *= -1;
    }
}

if(!holographic && holo_alpha != -1)
{
    holo_alpha = 1;
}

// OBJECT CENTER OFFSET
if(obj_center_offset && !obj_center_updated)
{
    obj_center_dist = point_distance(0,0, obj_center_xoff, obj_center_yoff);
    obj_center_angle = point_direction(0,0, obj_center_xoff, obj_center_yoff);
    
    obj_center_updated = true;
}

// TERRAIN OPTIMIZATION

if(read_terrain)
{
    var hor_min, hor_max, ver_min, ver_max, xx, yy, list, size, cur_grid_x, cur_grid_y;
    
    if(ter_list == noone)
    {
        ter_list = ds_list_create();
    }
    
    // GRID POSITION
    //if(room == alpinus_sandbox || room == tutorial || room == tutorial_backup || room == face_arena || room == mayhemburger_arena)
    if(room != chase)
    {
        cur_grid_x = floor((x - singleton_obj.grid_margin)/singleton_obj.grid_cell_size);
    }
    else
    {
        cur_grid_x = 0;
    }
    cur_grid_y = floor((y - singleton_obj.grid_margin)/singleton_obj.grid_cell_size);
    
    // GRID SECTION UPDATE
    if(cur_grid_x != ter_grid_x || cur_grid_y != ter_grid_y)
    {
        ds_list_clear(ter_list);
        
        hor_min = cur_grid_x - ter_left;
        hor_max = cur_grid_x + ter_right;
        ver_min = cur_grid_y - ter_up;
        ver_max = cur_grid_y + ter_down;
        
        // MAKE SURE EDGES ARE INSIDE GRID
        hor_min = max(0,hor_min);
        hor_min = min(hor_min,singleton_obj.grid_width - 1);
        
        hor_max = max(0,hor_max);
        hor_max = min(hor_max,singleton_obj.grid_width - 1);

        ver_min = max(0,ver_min);
        ver_min = min(ver_min,singleton_obj.grid_height - 1);
        
        ver_max = max(0,ver_max);
        ver_max = min(ver_max,singleton_obj.grid_height - 1);
        
        // POPULATE TERRAIN LIST
        for(yy = ver_min; yy <= ver_max; yy += 1)
        {
            for(xx = hor_min; xx <= hor_max; xx += 1) 
            {
                list = ds_grid_get(singleton_obj.terrain_grid,xx,yy);
                size = ds_list_size(list);
                
                for(i=0; i < size; i+=1)
                {
                    ds_list_add(ter_list, ds_list_find_value(list,i));
                }
            }
        }
        
        ter_list_length = ds_list_size(ter_list);
        
        // UPDATE GRID POSITION
        ter_grid_x = cur_grid_x;
        ter_grid_y = cur_grid_y;

    }
}
