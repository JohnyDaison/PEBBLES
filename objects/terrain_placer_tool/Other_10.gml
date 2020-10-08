if(active)
{
    erase = false;
    destructible = false;
    colorable = false;
    palette_index = mode;

    switch(mode)
    {
        case 0:
            erase = true;
            //create = terrain_placer_toolbar.create_checkbox.checked;
            //overwrite = terrain_placer_toolbar.overwrite_checkbox.checked;
        break;
        
        case 1:
            destructible = false;
            colorable = false;
            create = terrain_placer_toolbar.create_checkbox.checked;
            overwrite = terrain_placer_toolbar.overwrite_checkbox.checked;
        break;
        
        case 2:
            destructible = true;
            colorable = true;
            create = terrain_placer_toolbar.create_checkbox.checked;
            overwrite = terrain_placer_toolbar.overwrite_checkbox.checked;
        break;
    }
    
}

