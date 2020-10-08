energy = 0;
my_color = g_black;
damage = 0;
color_locked = false;
custom_sprite = false;
black_tint = DB.colormap[? g_black];
tint = black_tint;
tint_updated = false;
outburst_threshold = DB.terrain_config[? "outburst_threshold"];

alarm[0] = gamemode_obj.regenerate_terrain_delay;