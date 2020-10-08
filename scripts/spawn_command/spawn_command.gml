/// @description spawn_command(object, [number])
/// @function spawn_command
/// @param object
/// @param [number]
function spawn_command() {

	var object = argument[0];
	var number = 1;
	var spawned = 0;

	if(argument_count > 1)
	{
	    number = argument[1];
	}

	if(object_is_child(object, terrain_obj))
	{
	    var start_x = (cursor_obj.room_x div 32)*32;
	    var start_y = (cursor_obj.room_y div 32)*32;
	    var tries = 0;
	    var hor_count = ceil(sqrt(number)), hor_i = 0, vert_i = 0, xx, yy;
    
	    while(tries < number)
	    {
	        for(hor_i = 0; hor_i < hor_count; hor_i++)
	        {
	            xx = start_x + hor_i * 32;
	            yy = start_y + vert_i * 32;
	            tries++;
    
	            var ter = instance_position(xx,yy, terrain_obj);
	            if(!instance_exists(ter))
	            {
	                instance_create(xx, yy, object);
	                spawned++;
	            }
	        }
        
	        vert_i++;
	    }
	}
	else
	{
	    for(var i=0; i < number; i++)
	    {
	        var inst = instance_create(cursor_obj.room_x, cursor_obj.room_y, object);
	        if(object == slime_mob_obj)
	        {
	            inst.my_color = irandom_range(g_red, g_azure);
	        }
	    }
	    spawned = number;
	}

	return spawned;


}
