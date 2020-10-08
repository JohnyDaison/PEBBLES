event_inherited();

//speech_terms_destroy();
ds_map_destroy(term_index_map);

ds_list_destroy(word_list);
ds_list_destroy(display_word_list);
ds_map_destroy(display_word_progress_map);
ds_map_destroy(line_width);