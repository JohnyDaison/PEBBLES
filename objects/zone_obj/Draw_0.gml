draw_set_color(zone_debug_tint);

draw_set_alpha(0.2);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);

draw_set_alpha(0.4);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

draw_set_alpha(1);
draw_set_color(c_white);
my_draw_set_font(label_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(bbox_left+10, bbox_top+10, zone_id);
draw_text(bbox_left+10, bbox_top+42, string(ds_list_size(inside_list)));
