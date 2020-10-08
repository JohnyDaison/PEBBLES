/// @function has_left_me(instance);
/// @param instance
function has_left_me() {
	var inst = argument[0];

	var hl_value = inst.has_left_inst[? id];
	var has_left = is_undefined(hl_value) || hl_value;

	return has_left;


}
