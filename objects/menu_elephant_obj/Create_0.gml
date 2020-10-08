event_inherited();

parent_frame = id;

elephant_label = gui_add_label(200, 216, "Don't worry about" + "\n" + "the elephant in the room.");
elephant_label.height *= 2;
elephant_label.depth -= 5;
elephant_label.draw_border = false;
elephant_label.draw_bg_color = false;
//elephant_label.font = bigger_label_font;

// x was 1116
elephant_label = gui_add_label(view_wport[0]-164, view_hport[0]/2 + 280,"Everything is temporary" + "\n" + "Nothing is " + choose("final","perfect","real")); //  + "\n" + "Not even you"
elephant_label.height *= 3;
elephant_label.depth -= 5;
elephant_label.draw_border = false;
elephant_label.draw_bg_color = false;
//elephant_label.font = bigger_label_font;

elephant_width = 300;
elephant_x = elephant_width/2;
elephant_min_wait = 3600;
elephant_max_wait = 18000;
elephant_peek_speed = 0.6;
elephant_hide_speed = 5;
elephant_move_dir = 0;
alarm[11] = irandom_range(elephant_min_wait, elephant_max_wait);
