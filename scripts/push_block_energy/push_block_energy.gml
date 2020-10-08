/// @description push_block_energy(from, to, min_energy_tick, max_energy_tick, [from_min_energy], [to_max_energy])
/// @function push_block_energy
/// @param from
/// @param to
/// @param min_energy_tick
/// @param max_energy_tick
/// @param from_min_energy
/// @param to_max_energy
function push_block_energy() {

	var from = argument[0];
	var to = argument[1];
	var min_energy_tick = argument[2];
	var max_energy_tick = argument[3];
	var from_min_energy = 0;
	var to_max_energy = -1;

	if(argument_count > 4)
	{
	    from_min_energy = argument[4];
	}

	if(argument_count > 5)
	{
	    to_max_energy = argument[5];
	}

	var available, free_capacity, transferable = 0;

	if(instance_exists(from) && instance_exists(to))
	{
	    if(from.energy > from_min_energy && from.my_color != g_black && from.my_next_color != g_black
	    && (to.my_next_color == from.my_next_color || (to.my_color == g_black && to.my_next_color == g_black)))
	    {
	        available = min(from.energy - from_min_energy, max_energy_tick);
        
	        if(available >= min_energy_tick)
	        {
	            transferable = available;
	        }
        
	        if(to_max_energy != -1)
	        {
	            free_capacity = to_max_energy - (to.energy + to.direct_input_buffer);
	            transferable = min(transferable, free_capacity);
	        }
    
	        if(transferable > 0)
	        {
	            from.energy -= transferable;
	            //my_console_log("PUSHED ENERGY " + string(transferable));
        
	            to.direct_input_buffer += transferable;
	            to.my_next_color = from.my_next_color;
                
	            if(from.energy == 0 && from.direct_input_buffer == 0)
	            {
	                from.my_next_color = g_black;
	            }
	        }
	    }
	}


}
