if(paused) {
    alarm[1] = 1;
}

DB.mouse_has_moved = false;
cursor_obj.tooltip = "";

if(!paused)
{
    step_count = 0;
    terrain_checked = false;
}


display_updated = false;
update_display();

/*
TOO LATE HERE!
if(instance_exists(gamemode_obj) && !gamemode_obj.limit_reached)
{
    if(!instance_exists(chunkgrid_obj))
    {
        instance_create(0,0, chunkgrid_obj);
    }
}
*/
