if(self.tint_updated == false)
{
    self.tint = ds_map_find_value(DB.colormap,my_color);
    self.tint_updated = true;
}

