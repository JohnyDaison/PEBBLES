function end_test_script() {
    with(pickup_spawner_obj)
    {
        instance_destroy();
    }

    with(item_obj)
    {
        instance_destroy();
    }

    with(artifact_obj)
    {
        instance_destroy();
    }

    with(field_obj)
    {
        instance_destroy();
    }

    with(empty_frame)
    {
        instance_destroy();
    }

    with(guy_spawner_obj)
    {
        instance_destroy();
    }

    with(jump_pad_obj)
    {
        instance_destroy();
    }

    with(turret_mount_obj)
    {
        instance_destroy();
    }


    with(guy_obj)
    {
        instance_destroy();
    }

    with(particle_obj)
    {
        instance_destroy();
    }

    with(color_orb_obj)
    {
        instance_destroy();
    }

    with(spell_obj)
    {
        instance_destroy();
    }

    with(terrain_obj)
    {
        instance_destroy();
    }

    with(camera_obj)
    {
        if(id != editor_camera.id)
        {
            instance_destroy();
        }
    }

    with(gamemode_obj)
    {
        instance_destroy();
    }

    for(i=1;i<=7;i+=1)
    {
        __view_set( e__VW.Visible, i, false );
    }

    __view_set( e__VW.Visible, 0, true );
    /*
    background_color = make_color_rgb(0,29,43);
    background_visible[0] = false;
    background_visible[1] = false;
    */
    editor_camera.on = true;

    with(editor_object)
    {
        visible = true;
    }

    with(editor_terrain_obj)
    {
        terrain_grid_insert();
        visible = true;
    }

    add_frame(main_editor_toolbar);
    i = add_frame(main_tools_toolbar);
    i.x = main_editor_toolbar.x;
    i.y = main_editor_toolbar.y + main_editor_toolbar.height+1;

    i = add_frame(minimap_toolbar);
    i.x = display_get_gui_width() - i.width;
    i.y = display_get_gui_height() - i.height;

    instance_create(0, 0, grid_drawer);

    frame_manager.enable_focus_shift = true;

    __background_set_colour( c_black );
}
