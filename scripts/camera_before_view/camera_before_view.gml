function camera_before_view() {
    var i;
    for(i=0;i<2;i+=1)
    {
        //background_x[i] = view_xview[view]*bg_shift_ratio[i] + main_camera_obj.bg_xoffset*bg_speed_ratio[i];
        //background_y[i] = view_yview[view]*bg_shift_ratio[i] + main_camera_obj.bg_yoffset*bg_speed_ratio[i];
        var bg_scale = lerp(1/zoom_level, 1, bg_zoom_ratio[i]);
        __background_set( e__BG.X, i, (x*bg_shift_ratio[i] - bg_scale*__background_get( e__BG.Width, i )/2)
                        + main_camera_obj.bg_xoffset*bg_scale*bg_speed_ratio[i] );
        __background_set( e__BG.Y, i, (y*bg_shift_ratio[i] - bg_scale*__background_get( e__BG.Height, i )/2)
                        + main_camera_obj.bg_yoffset*bg_scale*bg_speed_ratio[i] );

        /*
        var layer_id = layer_get_id("Compatibility_Background_"+string(i));
        var back_id = layer_background_get_id(layer_id);
        var _layer_depth = layer_get_depth(layer_id);
        */
        /*
        layer_background_xscale(back_id, bg_scale);
        layer_background_yscale(back_id, bg_scale);
        */
    
        __background_set( e__BG.XScale, i, bg_scale );
        __background_set( e__BG.YScale, i, bg_scale );
    
    
        //__background_set( e__BG.Visible, i, false );
        //background_visible[i] = true;
    }

    // TERRAIN DRAWING OPTIMIZATION

    if(read_terrain)
    {
        var ter_block, cell_width, cell_height, hor_min, hor_max, ver_min, ver_max, xx, yy, list, size;
    
        if(ter_list == noone)
        {
            ter_list = ds_list_create();
        }
    
        // GRID POSITION
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
        if(cur_grid_x != ter_grid_x || cur_grid_y != ter_grid_y || singleton_obj.step_count mod 5 == 0)
        {
            // HIDE OLD
            for(i=ter_list_length-1; i>=0; i-=1)
            {
                ter_block = ds_list_find_value(self.ter_list, i);
                if(!is_undefined(ter_block) && instance_exists(ter_block))
                {
                    ter_block.visible = false;
                } 
            }
            ds_list_clear(ter_list);
            ter_list_length = 0;
        
            // BASE AREA
            cell_width = ceil(__view_get( e__VW.WView, view ) / singleton_obj.grid_cell_size);
            cell_height = ceil(__view_get( e__VW.HView, view ) / singleton_obj.grid_cell_size);
            hor_min = cur_grid_x - ceil(cell_width/2);
            hor_max = cur_grid_x + ceil(cell_width/2);
            ver_min = cur_grid_y - ceil(cell_height/2);
            ver_max = cur_grid_y + ceil(cell_height/2);
        
            // MAKE SURE EDGES CASES STILL SEE TERRAIN
        
            hor_min = min(hor_min,singleton_obj.grid_width - cell_width -1);
            hor_min = max(0,hor_min);
        
            hor_max = max(cell_width,hor_max);
            hor_max = min(hor_max,singleton_obj.grid_width - 1);

            ver_min = min(ver_min,singleton_obj.grid_height - cell_height -1);
            ver_min = max(0,ver_min);
        
            ver_max = max(cell_height,ver_max);
            ver_max = min(ver_max,singleton_obj.grid_height - 1);
        
            /*
            show_debug_message("hor_min: "+string(hor_min));
            show_debug_message("hor_max: "+string(hor_max));
            show_debug_message("ver_min: "+string(ver_min));
            show_debug_message("ver_max: "+string(ver_max));
            */
        
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
    
        // HIDE PREVIOUS CAM'S TERRAIN
        previous_cam = noone;
    
        with(player_camera_obj)
        {
            if(other.view > 1 && view == other.view - 1)
            {
                other.previous_cam = self.id;
            }
            if(other.view == 1 && view == main_camera_obj.count)
            {
                other.previous_cam = self.id;
            }
        }
    
        if(instance_exists(previous_cam) && previous_cam != id)
        {
            for(i=previous_cam.ter_list_length-1; i>=0 ; i-=1)
            {
                ter_block = ds_list_find_value(previous_cam.ter_list, i);
                if(!is_undefined(ter_block) && instance_exists(ter_block))
                {
                    ter_block.visible = false;
                }
            }
        }
    
        // DISPLAY MY TERRAIN
        for(i=ter_list_length-1; i>=0; i-=1)
        {
            ter_block = ds_list_find_value(self.ter_list, i);
            //show_debug_message("ter_block: "+string(ter_block));
            if(!is_undefined(ter_block) && instance_exists(ter_block))
            {
               ter_block.visible = true;
            }   
        }
    }

    // NON TERRAIN DRAWING OPTIMIZATION
    if(singleton_obj.do_my_visible_optim)
    {
        var is_not_debug = DB.console_mode != "debug";
        
        // this does bullshit when you spam Alt+U in Shooting Range (room_shotshell_test)
        // "self" inside the with() can be red_colorizer_obj or <undefined>. WTF!
        with(non_terrain_obj)
        {
            if(!is_undefined(self) && object_is_child(id, non_terrain_obj) && object_index != beam_obj && object_index != lightning_strike_obj)
            {
                if(object_out_of_view(id, other.id))
                {
                    visible = false;
                }
                else if(!invisible)
                {
                    visible = true;
                
                    // show duplicated items only to their player
                    if(is_not_debug)
                    {
                        if(object_is_child(id, item_obj) && for_player != -1 && !collected)
                        {
                            if(other.view != for_player)
                            {
                                visible = false;
                            }
                        }
                    }
                }
            }
        }
    }

    main_camera_obj.gui_fix_applied = false;
}
