energy = 0;
my_color = g_dark;
damage = 0;
color_locked = false;
custom_sprite = false;
black_tint = DB.colormap[? g_dark];
tint = black_tint;
tint_updated = false;
outburst_threshold = DB.terrain_config[? "outburst_threshold"];
body_offset_step = 4;

alarm[0] = gamemode_obj.regenerate_terrain_delay;