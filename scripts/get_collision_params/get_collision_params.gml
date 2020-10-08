/// @description get_collision_params(type, object_index)
/// @param type
/// @param object_index
function get_collision_params() {

	var type = argument[0];
	var index = argument[1];

	var type_map = DB.collision_map[? type];
	if(is_undefined(type_map))
	{
	    return undefined;   
	}

	var coll_params = type_map[? index];

	return coll_params;


}
