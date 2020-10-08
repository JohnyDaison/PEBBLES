action_inherited();
self.grid_width = singleton_obj.grid_width;
self.grid_height = singleton_obj.grid_height;
self.width = (grid_width)*12+16;
self.height = (grid_height)*18+16;
self.bg_color = c_black;
self.bg_alpha = 0.7;

x=32;
y=96;
window_axis = x+self.width/2;

var xx,yy, da_list;

for(yy=0; yy<grid_height; yy+=1)
{
    self.ter_text[yy] = "";
    for(xx=0; xx<grid_width; xx+=1)
    {
        da_list = ds_grid_get(singleton_obj.terrain_grid,xx,yy);
        self.ter_text[yy] += string(ds_list_size(da_list));
    }
}

