/// @description find_nearest_instances(from, object, [range, condition, param])
/// @function find_nearest_instances
/// @param from
/// @param object
/// @param [range]
/// @param [condition]
/// @param [param]
function find_nearest_instances() {
	var from = argument[0];
	var object = argument[1];
	var range = 1024;
	var condition = "";
	var param = "";
	var visible_type = "move";

	if(argument_count > 2)
	{
	    range = argument[2];
	}

	if(argument_count > 3)
	{
	    condition = argument[3];
	}

	if(argument_count > 4)
	{
	    param = argument[4];
	}

	if(condition == "visible")
	{
	    visible_type = param;   
	}

	var count, i, instance, dist;

	var results = ds_list_create(), new_result, result, position;
	register_ds("results", "ds_list_of_map", results, id);


	with(from)
	{
	    with(object)
	    {    
	        instance = id;
	        with(other)
	        {
	            dist = point_distance(x,y, instance.x, instance.y);
        
	            // npc_line_of_sight might not be the best script for this purpose
	            if((dist <= range || range == -1)
	            && (condition != "visible" || npc_line_of_sight_instance(instance, visible_type))
	            && (condition != "holographic" || instance.holographic == param)
	            && (condition != "player" || instance.my_player == param)
	            && (condition != "with_label_not_mine" || (instance.my_guy != id && instance.draw_label == param))
	            )
	            {
	                new_result = ds_map_create();
	                new_result[? "id"] = instance;
	                new_result[? "distance"] = dist;
                
	                count = ds_list_size(results);
	                position = count;
                
	                for(i=0; i < count; i++)
	                {
	                    result = results[| i];
	                    if(result[? "distance"] > dist)
	                    {
	                        position = i;
	                        break;
	                    }
	                }
                
	                ds_list_insert(results, position, new_result);
	            }
	        }
	    }
	}

	return results;


}
