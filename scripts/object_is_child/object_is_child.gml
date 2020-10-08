/// @description object_is_child(child, parent_index)
/// @function object_is_child
/// @param child
/// @param  parent_index
function object_is_child(argument0, argument1) {
	var child = argument0;
	var parent_index = argument1;

	var child_index;

	if(instance_exists(child))
	{
	    child_index = child.object_index;
	}
	else if(object_exists(child))
	{
	    child_index = child;
	}
	else
	{
	    return false;
	}

	if(!object_exists(parent_index))
	{
	    return false;
	}

	return (child_index == parent_index || object_is_ancestor(child_index, parent_index));



}
