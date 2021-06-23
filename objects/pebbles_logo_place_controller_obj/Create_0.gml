event_inherited();

torch_sequence = ds_list_create();
torch_sequence_started = false;
torch_sequence_finished = false;
torch_color_index = 0;
torch_obj = noone;

torch_sequence_wait_time = 3;
ds_list_add(torch_sequence, g_red, g_yellow, g_green, g_cyan, g_blue, g_magenta, g_white, g_octarine);
torch_energy_tick = 0.04;