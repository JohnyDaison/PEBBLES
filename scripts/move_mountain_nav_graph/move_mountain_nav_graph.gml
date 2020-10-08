/// @description move_mountain_nav_graph()
/// @function move_mountain_nav_graph
function move_mountain_nav_graph() {

	var i=1; 

	// WAYPOINTS

	nav_graph_add_node("welcome/active", i);
	nav_graph_add_node("welcome/success", i);

	nav_graph_add_node("first_jump/active", i);
	nav_graph_add_node("first_jump/failure", i);
	nav_graph_add_node("first_jump/success", ++i);

	nav_graph_add_node("second_jump/active", i);
	nav_graph_add_node("second_jump/failure", i);
	nav_graph_add_node("second_jump/success", ++i);

	nav_graph_add_node("doublejump_pickup/active", i);
	nav_graph_add_node("doublejump_pickup/success", ++i);


	nav_graph_add_node("double_jump/active", i);
	nav_graph_add_node("double_jump/failure", i);
	nav_graph_add_node("double_jump/success", ++i);

	nav_graph_add_node("double_jump_up/active", i);
	nav_graph_add_node("small_tree_top", i);
	nav_graph_add_node("double_jump_up/success", ++i);

	nav_graph_add_node("double_jump2/active", i);
	nav_graph_add_node("big_tree_top", i);
	nav_graph_add_node("down_in_forest", i);
	nav_graph_add_node("forest_ledge", i);
	nav_graph_add_node("double_jump2/success", ++i);


	nav_graph_add_node("building_entrance_platform", i);
	nav_graph_add_node("building_entrance_under_ledge", i);
	nav_graph_add_node("building_entrance_ledge", i);
	nav_graph_add_node("building_entrance", i);
	nav_graph_add_node("building_turn", i);
	nav_graph_add_node("drop_jump/failure", i);
	nav_graph_add_node("building_fail_exit", i);

	nav_graph_add_node("drop_jump/active", i);
	nav_graph_add_node("drop_jump_turn_point", i);
	nav_graph_add_node("drop_jump/success", ++i);

	nav_graph_add_node("building_exit_drop", i);


	nav_graph_add_node("triple_jump_pickup", i);
	nav_graph_add_node("triple_jump/active", i);
	nav_graph_add_node("triple_jump/failure", i);
	nav_graph_add_node("triple_jump/success", ++i);

	nav_graph_add_node("charged_jump_pickup", i);
	nav_graph_add_node("charged_jump/active", i);
	nav_graph_add_node("charged_jump/success", ++i);

	nav_graph_add_node("charged_jump_up/active", i);
	nav_graph_add_node("charged_jump_up/success", ++i);


	nav_graph_add_node("gloves_pickup/active", i);
	nav_graph_add_node("gloves_pickup/success", i);
	nav_graph_add_node("gloves_area_ledge_bottom", i);
	nav_graph_add_node("wall_climb/failure", i);

	nav_graph_add_node("wall_climb/active", i);
	nav_graph_add_node("wall_climb/success", ++i);

	nav_graph_add_node("reach_wall_jump/active", i);
	nav_graph_add_node("reach_wall_jump/success", ++i);

	nav_graph_add_node("wall_jump/active", i);
	nav_graph_add_node("wall_jump/failure", i);
	nav_graph_add_node("wall_jump_start_point", i);
	nav_graph_add_node("wall_jump_turn_point", i);
	nav_graph_add_node("wall_jump_mistake", i);
	nav_graph_add_node("wall_jump/success", ++i);


	nav_graph_add_node("reach_jump_pad/active", i);
	nav_graph_add_node("reach_jump_pad/success", ++i);

	nav_graph_add_node("use_jump_pad/active", i);
	nav_graph_add_node("jump_pad", i);
	nav_graph_add_node("jump_pad_peak", i);
	nav_graph_add_node("use_jump_pad/success", ++i);

	nav_graph_add_node("reach_exit/active", i);
	nav_graph_add_node("reach_exit/success", ++i);

	// CONNECTIONS

	nav_graph_add_edge("welcome/active", "first_jump/active", "run", 2);
	//nav_graph_add_edge("welcome/active", "welcome/success", "run", 3);
	nav_graph_add_edge("welcome/success", "first_jump/active", "run", 2);
	nav_graph_add_edge("first_jump/active", "welcome/success", "run", 2);
	nav_graph_add_edge("welcome/success", "first_jump/failure", "run", 3);
	nav_graph_add_edge("welcome/success", "first_jump/active", "run", 2);
	nav_graph_add_edge("welcome/success", "first_jump/success", "jump", 3);
	nav_graph_add_edge("first_jump/success", "welcome/success", "jump", 3);

	nav_graph_add_edge("first_jump/success", "second_jump/active", "jump", 5);

	nav_graph_add_edge("second_jump/active", "second_jump/failure", "run", 6);
	nav_graph_add_edge("second_jump/failure", "second_jump/active", "run", 6);
	nav_graph_add_edge("second_jump/active", "second_jump/success", "jump", 5);
	nav_graph_add_edge("second_jump/success", "second_jump/active", "jump", 5);

	nav_graph_add_edge("second_jump/success", "doublejump_pickup/active", "run", 5);
	nav_graph_add_edge("doublejump_pickup/active", "doublejump_pickup/success", "run", 2);
	nav_graph_add_edge("doublejump_pickup/success", "double_jump/active", "run", 2);


	nav_graph_add_edge("double_jump/active", "double_jump/failure", "run", 7);
	nav_graph_add_edge("double_jump/failure", "second_jump/failure", "run", 11);

	nav_graph_add_edge("double_jump/active", "double_jump/success", "jump", 6);
	nav_graph_add_edge("double_jump/success", "double_jump/active", "jump", 6);
	nav_graph_add_edge("double_jump/success", "double_jump_up/active", "run", 1);

	nav_graph_add_edge("double_jump_up/active", "double_jump/success", "run", 1);
	nav_graph_add_edge("double_jump_up/active", "double_jump2/active", "jump", 6);

	nav_graph_add_edge("double_jump_up/active", "small_tree_top", "run", 8);
	nav_graph_add_edge("double_jump_up/active", "double_jump_up/success", "jump", 5);
	nav_graph_add_edge("small_tree_top", "big_tree_top", "run", 4);
	nav_graph_add_edge("down_in_forest", "small_tree_top", "jump", 5);
	nav_graph_add_edge("small_tree_top", "forest_ledge", "jump", 3);
	nav_graph_add_edge("double_jump_up/success", "double_jump2/active", "run", 1);

	nav_graph_add_edge("double_jump2/active", "double_jump_up/active", "jump", 6);
	nav_graph_add_edge("double_jump2/active", "double_jump2/success", "jump", 7);
	nav_graph_add_edge("double_jump2/success", "double_jump2/active", "jump", 7);
	nav_graph_add_edge("double_jump2/success", "big_tree_top", "run", 6);
	nav_graph_add_edge("big_tree_top", "small_tree_top", "run", 4);

	nav_graph_add_edge("forest_ledge", "big_tree_top", "jump", 3);
	nav_graph_add_edge("forest_ledge", "double_jump_up/active", "jump", 5);
	nav_graph_add_edge("drop_jump/failure", "building_fail_exit", "run", 3);
	nav_graph_add_edge("building_fail_exit", "big_tree_top", "run", 8);


	nav_graph_add_edge("double_jump2/success", "building_entrance_platform", "jump", 2);
	nav_graph_add_edge("building_entrance_platform", "building_entrance_ledge", "jump", 2);
	nav_graph_add_edge("building_entrance_under_ledge", "building_entrance_platform", "jump", 2);
	nav_graph_add_edge("building_entrance_ledge", "building_entrance", "run", 3);
	nav_graph_add_edge("building_entrance", "building_turn", "run", 9);
	nav_graph_add_edge("building_turn", "drop_jump/active", "run", 5);

	nav_graph_add_edge("drop_jump/active", "drop_jump_turn_point", "run", 2);
	nav_graph_add_edge("drop_jump_turn_point", "drop_jump/success", "jump", 3);

	nav_graph_add_edge("drop_jump/success", "building_exit_drop", "run", 7);
	nav_graph_add_edge("building_exit_drop", "triple_jump_pickup", "run", 5);


	nav_graph_add_edge("triple_jump_pickup", "triple_jump/active", "run", 7);
	nav_graph_add_edge("triple_jump/active", "triple_jump/failure", "run", 8);
	nav_graph_add_edge("triple_jump/failure", "triple_jump/active", "run", 8);
	nav_graph_add_edge("triple_jump/active", "triple_jump/success", "jump", 9);
	nav_graph_add_edge("triple_jump/success", "triple_jump/active", "jump", 9);
	nav_graph_add_edge("triple_jump/success", "triple_jump/failure", "run", 5);

	nav_graph_add_edge("triple_jump/success", "charged_jump_pickup", "run", 7);
	nav_graph_add_edge("charged_jump_pickup", "charged_jump/active", "run", 1);
	nav_graph_add_edge("charged_jump/active", "charged_jump/success", "jump", 8);
	nav_graph_add_edge("charged_jump/success", "charged_jump/active", "jump", 8);

	nav_graph_add_edge("charged_jump/success", "charged_jump_up/active", "run", 8);
	nav_graph_add_edge("charged_jump_up/active", "charged_jump_up/success", "jump", 7);
	nav_graph_add_edge("charged_jump_up/success", "charged_jump_up/active", "run", 7);


	nav_graph_add_edge("charged_jump_up/success", "gloves_pickup/active", "run", 22);
	nav_graph_add_edge("gloves_pickup/active", "gloves_pickup/success", "run", 11);

	nav_graph_add_edge("gloves_pickup/success", "gloves_area_ledge_bottom", "jump", 7);
	nav_graph_add_edge("gloves_area_ledge_bottom", "wall_climb/failure", "jump", 3);
	nav_graph_add_edge("wall_climb/failure", "wall_climb/active", "run", 1);
	nav_graph_add_edge("wall_climb/active", "wall_climb/success", "jump", 10);

	nav_graph_add_edge("wall_climb/success", "reach_wall_jump/active", "run", 1);
	nav_graph_add_edge("reach_wall_jump/success", "wall_jump/active", "run", 4);
	nav_graph_add_edge("wall_jump/active", "reach_wall_jump/success", "run", 4);
	nav_graph_add_edge("reach_wall_jump/active", "wall_jump/active", "run", 15);

	nav_graph_add_edge("wall_jump/active", "wall_jump_start_point", "run", 2);
	nav_graph_add_edge("wall_jump_mistake", "wall_jump_start_point", "run", 7);
	nav_graph_add_edge("wall_jump_start_point", "wall_jump/active", "run", 2);
	nav_graph_add_edge("wall_jump_start_point", "wall_jump_turn_point", "jump", 7);
	nav_graph_add_edge("wall_jump_turn_point", "wall_jump/success", "jump", 9);
	nav_graph_add_edge("wall_jump/failure", "wall_jump/active", "run", 2);
	nav_graph_add_edge("wall_jump/active", "wall_jump/failure", "run", 2);


	nav_graph_add_edge("wall_jump/success", "reach_jump_pad/active", "jump", 7);
	nav_graph_add_edge("reach_jump_pad/active", "reach_jump_pad/success", "jump", 11);
	nav_graph_add_edge("reach_jump_pad/success", "reach_jump_pad/active", "jump", 11);

	nav_graph_add_edge("reach_jump_pad/success", "use_jump_pad/active", "run", 3);
	nav_graph_add_edge("use_jump_pad/active", "jump_pad", "run", 1);
	nav_graph_add_edge("jump_pad", "jump_pad_peak", "jump", 1);
	nav_graph_add_edge("jump_pad_peak", "use_jump_pad/success", "jump", 1);
	nav_graph_add_edge("use_jump_pad/success", "reach_exit/active", "run", 6);
	nav_graph_add_edge("reach_exit/active", "reach_exit/success", "run", 5);


}
