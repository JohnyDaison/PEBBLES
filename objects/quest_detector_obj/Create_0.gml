event_inherited();

my_color = g_black;
energy = 0;
// states: recharging, ready, active
ready = true;
active = false;
immovable = true;
radius = 16;

range = 640;

context_id = "";
quest_id = "";
subtask_id = "";
last_subtask_state = "";
for_player = -1; // in this case -1 means only players, world should be excluded
reward_energy = 0;
reward_color = g_nothing;

draw_label = false;
name = "Quest detector";
