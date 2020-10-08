/// @description additive_list_copy(target, source);
/// @function additive_list_copy
/// @param target
/// @param source
function additive_list_copy() {

	var target = argument[0];
	var source = argument[1];

	var count = ds_list_size(source);
	var i;

	for(i = 0; i < count; i++)
	{
	    ds_list_add(target, source[| i]);
	}



}
