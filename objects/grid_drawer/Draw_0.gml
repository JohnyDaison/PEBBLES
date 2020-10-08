
hcell_count = (right_bound-left_bound)/32;
vcell_count = (bottom_bound-top_bound)/32;

draw_set_color(line_color);
my_draw_set_font(little_font);

draw_set_alpha(0.9);

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

left_count_start = (left_bound - place_obj.x)/32;
top_count_start = (top_bound - place_obj.y)/32;

for(i=0; i<hcell_count; i+=1)
{
    my_draw_text(left_bound + i*32+16, top_bound-2, string_hash_to_newline(string(left_count_start+i+1)));   
}

draw_set_halign(fa_right);
draw_set_valign(fa_center);

for(i=0; i<vcell_count; i+=1)
{
    my_draw_text(left_bound-2, top_bound + i*32+16, string_hash_to_newline(string(top_count_start+i+1)));   
}

draw_set_alpha(0.7);

for(i=left_bound; i<=right_bound; i+=32)
{
    draw_line(i,top_bound,i,bottom_bound);   
}

for(i=top_bound; i<=bottom_bound; i+=32)
{
    draw_line(left_bound,i,right_bound,i);
}
draw_set_alpha(1);

