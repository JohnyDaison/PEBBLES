/// @description CHUNK UPDATE AND VIEW SHAKE

// CHUNK UPDATE
if(on)
{
    if(!instance_exists(chunkgrid_obj))
    {
        show_debug_message("CAM END [" + string(view) + "]");
    }
    else
    {
        var cur_grid_x, cur_grid_y;
        cur_grid_x = floor(x / chunkgrid_obj.chunk_size);
        cur_grid_y = floor(y / chunkgrid_obj.chunk_size);
        
        var moved_to_new_chunk = (cur_grid_x != obs_chunk_x || cur_grid_y != obs_chunk_y);
        
        // GRID SECTION STATE UPDATE
        if(moved_to_new_chunk && singleton_obj.step_count > 5)
        {
            schedule_chunk_optimizer();
        }
    }
}

// VIEW SHAKE
if(shake_dist > 0)
{
    last_shake_dist = shake_dist;
    
    if(shake_dist < 1)
    {
        shake_dist = 0;
    }
    else
    {
        shake_dist -= shake_dist_decay;
        shake_dir = (shake_dir + 180) mod 360;
    }
    
    x_diff = 2 * lengthdir_x(shake_dist, shake_dir);
    
    x += 2 * lengthdir_x(shake_dist, shake_dir);
    y += 2 * lengthdir_y(shake_dist, shake_dir); 
}


// NORMAL ZOOM
normal_zoom = base_normal_zoom;
if(singleton_obj.player_port_height < singleton_obj.current_height)
{
    normal_zoom = small_normal_zoom;
}
