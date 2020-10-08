function speech_terms_destroy() {
	ds_list_destroy(term_id_list);
	ds_list_destroy(term_name_list);

	ds_map_destroy(term_name_map);
	ds_map_destroy(term_color_map);


}
