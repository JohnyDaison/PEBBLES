event_inherited();

if(!instance_exists(chunkgrid_obj))
{
    singleton_obj.show_chunkgrid = false;
    close_frame(id);
    exit;
}

self.grid_width = chunkgrid_obj.grid_width;
self.grid_height = chunkgrid_obj.grid_height;
self.width = (grid_width)*32+48;
self.height = (grid_height)*32+64;
self.bg_color = c_black;
self.bg_alpha = 0.7;

x=320;
y=320;
window_axis = x+self.width/2;

self.heading = "";
var yy;

for(yy=0; yy<grid_height; yy+=1)
{
    self.ter_text[yy] = "";
}

depth = -2000;