/// @description battlefeed_post_new([type])
/// @function battlefeed_post_new
/// @param [type]
function battlefeed_post_new() {

	new_item = instance_create(0,0, battlefeed_item_obj);

	if(argument_count > 0)
	{
	    new_item.item_type = argument[0];
	}

	return new_item;



}
