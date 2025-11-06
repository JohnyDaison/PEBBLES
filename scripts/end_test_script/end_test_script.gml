function end_test_script() {
    with (pickup_spawner_obj) {
        instance_destroy();
    }

    with (item_obj) {
        instance_destroy();
    }

    with (artifact_obj) {
        instance_destroy();
    }

    with (field_obj) {
        instance_destroy();
    }

    with (empty_frame) {
        instance_destroy();
    }

    with (guy_spawner_obj) {
        instance_destroy();
    }

    with (jump_pad_obj) {
        instance_destroy();
    }

    with (turret_mount_obj) {
        instance_destroy();
    }


    with (guy_obj) {
        instance_destroy();
    }

    with (particle_obj) {
        instance_destroy();
    }

    with (color_orb_obj) {
        instance_destroy();
    }

    with (spell_obj) {
        instance_destroy();
    }

    with (terrain_obj) {
        instance_destroy();
    }

    with (camera_obj) {
        if (self.id != editor_camera.id) {
            instance_destroy();
        }
    }

    with (gamemode_obj) {
        instance_destroy();
    }

    for (var i = 1; i <= 7; i++) {
        view_set_visible(i, false);
    }

    view_set_visible(0, true);
    /*
    background_color = make_color_rgb(0,29,43);
    background_visible[0] = false;
    background_visible[1] = false;
    */
    editor_camera.on = true;

    with (editor_object) {
        self.visible = true;
    }

    with (editor_terrain_obj) {
        terrain_grid_insert();
        self.visible = true;
    }

    add_frame(main_editor_toolbar);
    var inst = add_frame(main_tools_toolbar);
    inst.x = main_editor_toolbar.x;
    inst.y = main_editor_toolbar.y + main_editor_toolbar.height + 1;

    inst = add_frame(minimap_toolbar);
    inst.x = display_get_gui_width() - inst.width;
    inst.y = display_get_gui_height() - inst.height;

    instance_create(0, 0, grid_drawer);

    frame_manager.enable_focus_shift = true;

    singleton_obj.changeBackgroundColor(c_black);
}
