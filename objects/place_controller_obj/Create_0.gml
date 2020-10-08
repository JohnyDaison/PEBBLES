event_inherited();

triggerable = true;
trigger_script = place_controller_trigger_script;

trigger_group_id = "";
trigger_group = noone;
checkpoint_group_id = "checkpoints";
checkpoint_group = noone;
npc_waypoint_group_id = "waypoints";
npc_waypoint_group = noone;

trigger_list = ds_list_create(); // list of keys
trigger_map = ds_map_create();  // maps keys to lists of triggerables

nav_graph_exists = false;
nav_graph_enabled = false;
auto_init_waypoints = false;
auto_generate_nav_graph = false;
generate_nav_graph = false;
remove_redundancy = true;

item_list = ds_list_create();
item_list_size = 0;
