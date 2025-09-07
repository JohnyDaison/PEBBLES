instance_create(0, 0, screen_fade_obj);

var bgColor = make_color_rgb(0, 0, 12);
singleton_obj.changeBackgroundColor(bgColor);

__background_set( e__BG.Index, 0, hexgrid_bg );
__background_set( e__BG.Index, 1, rectangles2_bg );

__background_set( e__BG.Visible, 0, true );
__background_set( e__BG.Visible, 1, true );

var m = add_frame(main_editor_toolbar);
m.x = 1;
m.y = 1;

var i = add_frame(main_tools_toolbar);
i.x = main_editor_toolbar.x;
i.y = main_editor_toolbar.y + main_editor_toolbar.height + 1;

minimap_toolbar_toggle();
