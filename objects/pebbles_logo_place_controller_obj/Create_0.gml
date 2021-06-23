event_inherited();

lightup_sequence = ds_list_create();
lightup_sequence_started = false;
lightup_sequence_finished = false;
lightup_sequence_index = -1;
lightup_sequence_wait_time = 3;
goto_next = true;

ds_list_add(lightup_sequence, "red_torch", "red_letter");
ds_list_add(lightup_sequence, "yellow_torch", "yellow_letter");
ds_list_add(lightup_sequence, "green_torch", "green_letter");
ds_list_add(lightup_sequence, "cyan_torch", "cyan_letter");
ds_list_add(lightup_sequence, "blue_torch", "blue_letter");
ds_list_add(lightup_sequence, "magenta_torch", "magenta_letter");
ds_list_add(lightup_sequence, "white_torch", "white_letter");
ds_list_add(lightup_sequence, "octarine_torch");

torch_obj = noone;
torch_energy_tick = 0.04;