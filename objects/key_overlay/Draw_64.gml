action_inherited();
draw_set_color(c_fuchsia);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
my_draw_set_font(label_font);

window_axis = x+self.width/2;

for(i=0;i<10;i+=1)
{
    key1 = ds_map_find_value(DB.key1,i);
    key2 = ds_map_find_value(DB.key2,i);
    my_draw_text(64*(i)+x,y,string_hash_to_newline(string(key1) + " " + string(keyboard_check_direct(key1))));
    my_draw_text(64*(i)+x,y+64,string_hash_to_newline(string(key2) + " " + string(keyboard_check_direct(key2))));
}  
my_draw_text(x,y+138,string_hash_to_newline("Last pressed: " + string(keyboard_lastkey)));

