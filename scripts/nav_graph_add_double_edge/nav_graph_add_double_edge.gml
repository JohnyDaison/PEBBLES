/// @description nav_graph_add_double_edge(from, to, type, cost, [nav_cost])
/// @function nav_graph_add_double_edge
/// @param from
/// @param to
/// @param type
/// @param cost
/// @param [nav_cost]
function nav_graph_add_double_edge() {
	var from = argument[0];
	var to = argument[1];
	var type = argument[2];
	var cost = argument[3];
	var nav_cost = cost;
	if(argument_count > 4)
	{
	    nav_cost = argument[4];
	}

	return nav_graph_add_edge(from, to, type, cost, nav_cost)
	    && nav_graph_add_edge(to, from, type, cost, nav_cost);


}
