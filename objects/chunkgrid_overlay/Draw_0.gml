/// @description draw lines in level

draw_set_alpha(0.5);
draw_set_color(c_orange);
my_draw_set_font(speech_popup_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var xx, yy;

for(yy=0; yy<grid_height; yy+=1)
{
    var y1 = yy*chunkgrid_obj.chunk_size;
    var y2 = y1 + chunkgrid_obj.chunk_size -1;
    for(xx=0; xx<grid_width; xx+=1)
    {
        var x1 = xx*chunkgrid_obj.chunk_size;
        var x2 = x1 + chunkgrid_obj.chunk_size -1;
        
        draw_rectangle(x1, y1, x2, y2, true);
        draw_text(x1 + 5, y1 + 5, string(xx) + ":" + string(yy));
    }
}