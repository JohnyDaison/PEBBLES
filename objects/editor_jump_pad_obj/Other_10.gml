last_color = color;
color = ceil(g_white*(max_power/DB.max_jump_pad_power));
if(last_color != color)
{
    self.tint = ds_map_find_value(DB.colormap,color);
    final_tint = tint;    
}
self.ready = (color > g_red);

