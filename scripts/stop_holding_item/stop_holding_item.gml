/// @description stop_holding_item(item)
/// @function stop_holding_item
/// @param item
function stop_holding_item(argument0) {
	var index = argument0;
	var item = held_item[? index];
	var inv_item = inventory[? index];

	held_item[? index] = noone;

	with(item)
	{
	    event_perform(ev_other, ev_user2);
    
	    if(!cursed)
	    {
	        hold_mode = false;
	    }
    
	    use_cooldown_left = use_cooldown_length;
    
	    if(destroy_on_use)
	    {
	        instance_destroy();
	    }
	}

	hold_mode = false;

	if(!is_undefined(inv_item) && instance_exists(inv_item))
	{
	    inv_item.use_cooldown_left = inv_item.use_cooldown_length;
	}



}
