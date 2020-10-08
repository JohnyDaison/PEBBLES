event_inherited();

str = "";
next_str = "";
line_offset = 0;
width = 128;
height = 36;
split_done = false;
spoken_count = 0;
display_str = "";
max_alpha = 1;
font = speech_popup_font;
bg_color = merge_color(c_black, c_white, 0.1);
//bg_color = c_ltgray;
y_offset = 0;
max_alpha_length = 60;
fade_out_dist = 60;
rise_speed = 0.3;
fade_out_length = floor(fade_out_dist / rise_speed);
speech_volume = 0.5;
speech_pitch = 1;
interrupted = false;

str_width = 0;
str_height = 0;
max_width = 448; // 384 1024
line_height = 32;
//word_spacing = 15;
my_draw_set_font(font);
word_spacing = string_width(" ");
short_word_width = 4*word_spacing;
word_list = ds_list_create();
wprd_count = 0;
display_word_list = ds_list_create();
display_word_progress_map = ds_map_create();
line_count = 0;
display_line_count = 0;
line_width = ds_map_create();
line_width[? 0] = 0;
max_line_width = 0;
instant = false;

vert_margin = 6;
hor_margin = 8;

apply_my_text_fix = false;

//speech_terms_create();
term_index_map = ds_map_create();

alarm[0] = -1;
alarm[2] = 2;

