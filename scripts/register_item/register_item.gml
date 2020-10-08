/// @description register_item(item)
/// @function register_item
/// @param item
function register_item() {

	var item = argument[0];

	if(!instance_exists(place_controller_obj))
	{
	    return false;   
	}

	if(instance_exists(item) && ds_list_find_index(place_controller_obj.item_list, item) == -1)
	{
	    ds_list_add(place_controller_obj.item_list, item);
	    place_controller_obj.item_list_size++;
    
	    return true;
	}

	return false;


}
