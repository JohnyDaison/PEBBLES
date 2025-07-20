script_execute(npc_destroy_script);

ds_list_destroy(current_path);
ds_list_destroy(attack_targets);

if (instance_exists(my_chunkgrid)) {
    observer_remove(my_chunkgrid, id);
}


event_inherited();
