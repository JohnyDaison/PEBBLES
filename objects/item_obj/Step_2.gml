/// @description TERRAIN COLLISION
/*
if(my_guy == id || self.placed)
{
    if(place_meeting(x,y,terrain_obj))
    {
        var xx = 0, yy = 0;
        
        while(place_meeting(x,y+yy,terrain_obj))
        {
            yy--;
        }
        
        while(place_meeting(x+xx,y,terrain_obj) && place_meeting(x-xx,y,terrain_obj))
        {
            xx++;
        }
        
        if(abs(xx) > abs(yy))
        {
            y += yy;
        }
        else
        {
            if(!place_meeting(x+xx,y,terrain_obj))
            {
                x += xx;
            }
            else
            {
                if(!place_meeting(x-xx,y,terrain_obj))
                {
                    x -= xx;
                }
            }
        }
    }
}
*/

if((my_guy == id || self.placed) && !instance_exists(stuck_to))
{
    if(place_meeting(x,y,terrain_obj))
    {
        //my_console_log("item in terrain");
        var debug_str = "ITEM TERRAIN ";
        
        var was_in_terrain = place_meeting(xprevious, yprevious, terrain_obj);
        var half_x = x - hspeed/2;
        var half_y = y - vspeed/2;
        var halfway_collision = place_meeting(half_x, half_y, terrain_obj);
        var moved = false;
        
        x = half_x;
        y = half_y;
        
        if(!halfway_collision)
        {
            moved = true;
            
            debug_str += "halfway return ";
        }
        
        if(!moved)
        {
            var max_dist = 96, dist_step = 16;
            var dir, dir_i, cur_dist = dist_step, min_dist = max_dist;
            
            var possible_dirs = ds_list_create();
            ds_list_add(possible_dirs, 0, 45, 90, 135, 180, 225, 270);
            var possible_dir_count = ds_list_size(possible_dirs);
        
            var min_dists = ds_map_create();
            for (dir_i = 0; dir_i < possible_dir_count; dir_i++)
            {
                dir = possible_dirs[| dir_i];
                min_dists[? dir] = max_dist;
            }
        
            var xx = 0, yy = 0;
            var xx_plus = 0, xx_minus = 0, yy_minus = 0;
            
            while(cur_dist <= max_dist)
            {
                for (dir_i = possible_dir_count - 1; dir_i >= 0; dir_i--)
                {
                    dir = possible_dirs[| dir_i];
                
                    xx = lengthdir_x(cur_dist, dir);
                    yy = lengthdir_y(cur_dist, dir);
                
                    if(!place_meeting(x+xx, y+yy, terrain_obj))
                    {
                        min_dists[? dir] = cur_dist;
                        min_dist = cur_dist;
                    }
                }
                
                if(min_dist < max_dist)
                {
                    debug_str += string(min_dist) + " ";
                    break;
                }
            
                cur_dist += dist_step;
            }
            /*
            my_console_log( string(min_dist) + " : "
                            + string(min_dists[? 0])   + " " 
                            + string(min_dists[? 45])  + " " 
                            + string(min_dists[? 90])  + " " 
                            + string(min_dists[? 135]) + " " 
                            + string(min_dists[? 180]) );*/
        
            if(min_dists[? 90] == min_dist)
            {
                y -= min_dist;
                moved = true;
                
                debug_str += "90" + " ";
            }
        
        
            for (dir_i = possible_dir_count - 1; dir_i >= 0 && !moved; dir_i--)
            {
                dir = possible_dirs[| dir_i];
     
                if(min_dists[? dir] == min_dist)
                {
                    xx = lengthdir_x(min_dist, dir);
                    yy = lengthdir_y(min_dist, dir);
                
                    x += xx;
                    y += yy;
                    moved = true;
                    
                    debug_str += string(dir) + " ";
                }
            }
        
            if(!moved && !was_in_terrain)
            {
                x = xprevious;
                y = yprevious;
                
                debug_str += "return to previous ";
            }
            
            my_console_log(debug_str);
        
            ds_list_destroy(possible_dirs);
            ds_map_destroy(min_dists);
        }
    }
}


//debug
//name = string(speed);

event_inherited();