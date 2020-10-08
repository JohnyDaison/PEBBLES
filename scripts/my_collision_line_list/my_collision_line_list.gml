/// @description my_collision_line_list(x1, y1, x2, y2, obj, prec, notme, list, ordered);
/// @function my_collision_line_list
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param obj
/// @param prec
/// @param notme
/// @param list
/// @param ordered
function my_collision_line_list() {

	// NEEDS REWORK

	var x1 = argument[0];
	var y1 = argument[1];
	var x2 = argument[2];
	var y2 = argument[3];
	var obj = argument[4];
	var prec = argument[5];
	var notme = argument[6];
	var list = argument[7];
	var ordered = argument[8];

	var count, i, instance, dist;
	var x_center = (x1 + x2) / 2;
	var y_center = (y1 + y2) / 2;

	// terrible performance!

	var results = ds_list_create(), result_number = 0, new_result, result, position;
	register_ds("results", "ds_list_of_map", results, id);

	ds_list_clear(list);

	with(obj)
	{    
	    instance = id;

	    with(other)
	    {
	        if(collision_line(x1, y1, x2, y2, instance, prec, notme))
	        {
	            dist = point_distance(instance.x, instance.y, x_center, y_center);
            
	            new_result = ds_map_create();
	            new_result[? "id"] = instance;
	            new_result[? "distance"] = dist;
                
	            count = ds_list_size(results);
	            position = count;
            
	            if(ordered)
	            {
	                for(i=0; i < count; i++)
	                {
	                    result = results[| i];
	                    if(result[? "distance"] > dist)
	                    {
	                        position = i;
	                        break;
	                    }
	                }
	            }
                
	            ds_list_insert(results, position, new_result);
	            ds_list_insert(list, position, instance);
	        }
	    }
	}

	return ds_list_size(list);


}
