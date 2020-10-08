if(active)
{
    erase = false;

    switch(mode)
    {
        case 0:
            erase = true;
        break;
        
        case 1:
            structure_radius = 32;
            create = structure_placer_toolbar.create_checkbox.checked;
            overwrite = structure_placer_toolbar.overwrite_checkbox.checked;
        break;
        
        case 2:
            structure_radius = 16;
            create = structure_placer_toolbar.create_checkbox.checked;
            overwrite = structure_placer_toolbar.overwrite_checkbox.checked;      
        break;
    }
    
}

