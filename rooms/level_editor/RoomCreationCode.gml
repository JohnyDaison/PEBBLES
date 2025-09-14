instance_create(0, 0, screen_fade_obj);

var bgColor = make_color_rgb(0, 0, 12);
singleton_obj.changeBackgroundColor(bgColor);

var bgLayer0 = __background_get_element(0)[0];
var bgLayer1 = __background_get_element(1)[0];

layer_background_sprite(bgLayer0, hexgrid_bg);
layer_background_sprite(bgLayer1, rectangles2_bg);

layer_background_visible(bgLayer0, true);
layer_background_visible(bgLayer1, true);

var m = add_frame(main_editor_toolbar);
m.x = 1;
m.y = 1;

var i = add_frame(main_tools_toolbar);
i.x = main_editor_toolbar.x;
i.y = main_editor_toolbar.y + main_editor_toolbar.height + 1;

minimap_toolbar_toggle();
