event_inherited();

var xx, yy, chunk;

self.heading = "00 ";

for(xx=0; xx<grid_width; xx+=1)
{
     self.heading += my_string_format(xx mod 100, 2, 0) + " ";
}

for(yy=0; yy<grid_height; yy+=1)
{
    self.ter_text[yy] = my_string_format(yy mod 100, 2, 0) + " ";
    for(xx=0; xx<grid_width; xx+=1)
    {
        chunk = ds_grid_get(chunkgrid_obj.grid,xx,yy);
        self.ter_text[yy] += string(chunk[? "observers"]) + string_char_at(chunk[? "state"], 1) + " ";
    }
}