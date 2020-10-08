/// @description item_hold_mode(index)
/// @function item_hold_mode
/// @param index
function item_hold_mode(argument0) {
	var index = argument0;

	with(my_guy)
	{
	    held_item[? index] = other.id;
	    hold_mode = true;
	}

	hold_mode = true;




}
