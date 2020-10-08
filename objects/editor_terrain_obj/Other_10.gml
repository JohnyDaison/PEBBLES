if(palette_index == 1)
{
    tint = c_gray;
}
if(palette_index == 2)
{
    tint = ds_map_find_value(DB.colormap,color);
}

final_tint = self.tint;
if(color != g_black)
{
    final_tint = merge_color(self.tint,c_white,0.1);   
}

image_index = max(0,image_index);

