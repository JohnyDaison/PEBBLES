function classic_arena_nav_graph() {

	var i=1; 

	// WAYPOINTS

	nav_graph_add_node("left_spawn", i);
	nav_graph_add_node("left_spawn_inner_edge", i);
	nav_graph_add_node("left_platform", i);
	nav_graph_add_node("left_top", i);
	nav_graph_add_node("top_center_left", i);
	nav_graph_add_node("top_center", i);
	nav_graph_add_node("top_center_right", i);
	nav_graph_add_node("right_top", i);
	nav_graph_add_node("right_platform", i);
	nav_graph_add_node("right_spawn_inner_edge", i);
	nav_graph_add_node("right_spawn", i);

	nav_graph_add_node("left_corner", i);
	nav_graph_add_node("left_under_spawn_inner_edge", i);
	nav_graph_add_node("left_under_platform", i);
	nav_graph_add_node("left_under_under_platform", i);
	nav_graph_add_node("left_bottom_near_platform", i);
	nav_graph_add_node("left_bottom_near_fall", i);
	nav_graph_add_node("bottom_fall_left", i);
	nav_graph_add_node("bottom_center_left", i);
	nav_graph_add_node("bottom_center_right", i);
	nav_graph_add_node("bottom_fall_right", i);
	nav_graph_add_node("right_bottom_near_fall", i);
	nav_graph_add_node("right_bottom_near_platform", i);
	nav_graph_add_node("right_under_under_platform", i);
	nav_graph_add_node("right_under_platform", i);
	nav_graph_add_node("right_under_spawn_inner_edge", i);
	nav_graph_add_node("right_corner", i);

	// CONNECTIONS

	nav_graph_add_double_edge("left_spawn", "left_spawn_inner_edge", "jump", 2);
	nav_graph_add_double_edge("right_spawn", "right_spawn_inner_edge", "jump", 2);

	nav_graph_add_edge("left_spawn", "left_platform", "jump", 6);
	nav_graph_add_edge("right_spawn", "right_platform", "jump", 6);

	nav_graph_add_double_edge("left_spawn_inner_edge", "left_platform", "jump", 4);
	nav_graph_add_double_edge("right_spawn_inner_edge", "right_platform", "jump", 4);

	nav_graph_add_double_edge("left_spawn_inner_edge", "left_top", "jump", 7);
	nav_graph_add_double_edge("right_spawn_inner_edge", "right_top", "jump", 7);


	nav_graph_add_double_edge("left_platform", "top_center", "jump", 9);
	nav_graph_add_double_edge("right_platform", "top_center", "jump", 9);

	nav_graph_add_double_edge("left_platform", "left_top", "jump", 4);
	nav_graph_add_double_edge("right_platform", "right_top", "jump", 4);

	nav_graph_add_double_edge("left_top", "top_center", "jump", 6);
	nav_graph_add_double_edge("right_top", "top_center", "jump", 6);

	nav_graph_add_double_edge("top_center_left", "top_center", "jump", 4);
	nav_graph_add_double_edge("top_center_right", "top_center", "jump", 4);

	nav_graph_add_double_edge("left_top", "top_center_left", "jump", 5);
	nav_graph_add_double_edge("right_top", "top_center_right", "jump", 5);


	nav_graph_add_double_edge("left_platform", "left_under_platform", "jump", 3);
	nav_graph_add_double_edge("right_platform", "right_under_platform", "jump", 3);


	nav_graph_add_edge("left_spawn", "left_corner", "jump", 9);
	nav_graph_add_edge("right_spawn", "right_corner", "jump", 9);

	nav_graph_add_edge("left_corner", "left_platform", "jump", 9);
	nav_graph_add_edge("right_corner", "right_platform", "jump", 9);

	nav_graph_add_double_edge("left_under_spawn_inner_edge", "left_platform", "jump", 4);
	nav_graph_add_double_edge("right_under_spawn_inner_edge", "right_platform", "jump", 4);

	nav_graph_add_double_edge("left_under_spawn_inner_edge", "left_under_platform", "jump", 2);
	nav_graph_add_double_edge("right_under_spawn_inner_edge", "right_under_platform", "jump", 2);

	nav_graph_add_double_edge("left_under_platform", "bottom_center_left", "jump", 8);
	nav_graph_add_double_edge("right_under_platform", "bottom_center_right", "jump", 8);

	nav_graph_add_double_edge("bottom_center_left", "bottom_center_right", "run", 3);


	nav_graph_add_double_edge("left_under_platform", "left_bottom_near_platform", "jump", 4);
	nav_graph_add_double_edge("right_under_platform", "right_bottom_near_platform", "jump", 4);

	nav_graph_add_double_edge("left_bottom_near_platform", "left_bottom_near_fall", "run", 4);
	nav_graph_add_double_edge("right_bottom_near_platform", "right_bottom_near_fall", "run", 4);

	nav_graph_add_double_edge("left_bottom_near_fall", "bottom_center_left", "jump", 3);
	nav_graph_add_double_edge("right_bottom_near_fall", "bottom_center_right", "jump", 3);

	nav_graph_add_double_edge("left_bottom_near_fall", "bottom_fall_left", "run", 2);
	nav_graph_add_double_edge("right_bottom_near_fall", "bottom_fall_right", "run", 2);

	nav_graph_add_double_edge("left_under_under_platform", "left_bottom_near_platform", "run", 2);
	nav_graph_add_double_edge("right_under_under_platform", "right_bottom_near_platform", "run", 2);


}
