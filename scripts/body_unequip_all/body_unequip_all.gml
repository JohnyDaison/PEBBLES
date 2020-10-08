/// @description body_unequip_all(body)
/// @function body_unequip_all
/// @param body
function body_unequip_all(argument0) {
	var body = argument0;

	var item;
	var count = ds_list_size(body.equipment_list);
	for(i=count-1; i>=0; i--)
	{
	    item = body.equipment_list[| i];
	    if(!is_undefined(item) && instance_exists(item))
	    {
	        with(item)
	        {
	            body_unequip(body, item.hardpoint);
	        }
	    }
	}



}
