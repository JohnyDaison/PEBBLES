if (cleanup_done) {
    exit;
}

var player_file_path = working_directory + "players.dat";
file_delete(player_file_path);

var player_file = file_text_open_write(player_file_path);
var player_str = ds_list_write(DB.player_names);

file_text_write_string(player_file, player_str);
file_text_close(player_file);

ds_list_destroy(were_persistent);

with(cursor_obj) {
    instance_destroy();
}

cleanup_done = true;
