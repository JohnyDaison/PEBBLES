file_delete(working_directory + "players.dat");
player_file = file_text_open_write(working_directory + "players.dat");
player_str = ds_list_write(DB.player_names);
file_text_write_string(player_file,player_str);
file_text_close(player_file);

ds_list_destroy(were_persistent);

with(cursor_obj)
{
    instance_destroy();
}
