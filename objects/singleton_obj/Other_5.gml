if(paused || (instance_exists(gamemode_obj) && gamemode_obj.limit_reached))
{
    my_sound_stop(all);
}

if(paused && instance_exists(console_window)) {
    close_frame(console_window);
}

if(!paused)
{
    if(grid_width > 0 && grid_height > 0)
    {
        show_terrain = false;
        terrain_grid_destroy(id);
    }
    
    with(chunkgrid_obj)
    {
        instance_destroy();
    }
}

DB.mouse_has_moved = false;
