/// @description quests_create()
/// @function quests_create
function quests_create() {
	DB.quest_node_ids = ds_list_create();
	DB.quest_nodes = ds_map_create();
	DB.quest_states = ds_list_create();
	DB.quest_context_divider = "/";

	ds_list_add(DB.quest_states, "init", "start", "active", "failure", "success");

	// Quick Tutorial
	quick_tut_movement_quest();
	quick_tut_base_colors_quest();
	quick_tut_catalyst_quest();
	quick_tut_basic_combat_quest();
	quick_tut_advanced_combat_quest();
	quick_tut_advanced_combat_quest_new();
	quick_tut_abilities_quest();

	// Training
	movement_mountain_quest();


}
