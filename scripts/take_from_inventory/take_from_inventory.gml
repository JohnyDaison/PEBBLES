/// @description take_from_inventory(item, [count])
/// @function take_from_inventory
/// @param item
/// @param [count]
function take_from_inventory() {

	var item = argument[0];
	var count = 1;
	if(argument_count > 1)
	{
	    count = argument[1];
	}

	var output = noone;

	if(instance_exists(item) && count > 0)
	{
	    var index = item.inv_index;
	    if(index > 0 && item.stack_size > 0 && item.stack_size >= count)
	    {
	        if(item.stack_size == count && !item.reserved)
	        {
	            item.inv_index = -1;
	            output = item;
	            ds_map_replace(inventory, index, noone);
	        }
	        else 
	        {
	            output = instance_create(x,y,item.object_index);
	            output.stack_size = count;
	            output.my_color = item.my_color;
	            output.collected = true;
	            output.my_guy = id;
	            output.my_player = my_player;
            
	            item.stack_size -= count;
	        }
        
	        output.x = x;
	        output.y = y;
	    }
	}

	return output;



}
