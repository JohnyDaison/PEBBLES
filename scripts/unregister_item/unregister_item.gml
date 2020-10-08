/// @description unregister_item(item)
/// @param item
function unregister_item() {

	var item = argument[0];

	if(!instance_exists(place_controller_obj))
	{
	    return false;   
	}

	var index = ds_list_find_index(place_controller_obj.item_list, item);

	if(index != -1)
	{
	    ds_list_delete(place_controller_obj.item_list, index);
	    place_controller_obj.item_list_size--;
	}

	return true;


}
