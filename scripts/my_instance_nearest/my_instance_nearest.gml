/// @description my_instance_nearest(x, y, type, who)
/// @param x
/// @param y
/// @param type
/// @param who
function my_instance_nearest() {

	var xx = argument[0];
	var yy = argument[1];
	var type = argument[2];
	var who = argument[3];

	var nearest_inst = noone;
	var nearest_dist = -1;
	var near, dist;


	if(type > coltypes_max)
	{
	    if(object_exists(type))
	    {
	        return instance_nearest(xx, yy, type);
	    }
	    else
	    {
	        return noone;   
	    }
	}

	//var coll_params = get_cached_collision_params(type, who);

	/*
	if(type == coltype_blocking)
	{
	    /*
	    var param_count = ds_list_size(coll_params);
	    for(var param_i = 0; param_i < param_count; param_i++)
	    {
	        near = instance_nearest(xx, yy, coll_params[| param_i]);
        
	        if(instance_exists(near))
	        {
	            near_xx = near.x + near.obj_center_xoff;
	            near_yy = near.y + near.obj_center_yoff;
            
	            dist = point_distance(xx, yy, near_xx, near_yy);
            
	            if(nearest_dist == -1 || dist < nearest_dist)
	            {
	                nearest_inst = near;
	                nearest_dist = dist;
	            }
	        }
	    }
	    */

	    /*
	    if(who.blocked_by_terrain || who.blocked_by_solid_terrain)
	    {
	        var ter_type;
        
	        if(!who.blocked_by_terrain)
	        {
	            ter_type = solid_terrain_obj;
	        }
	        else
	        {
	            ter_type = terrain_obj;
	        }
        
	        near = instance_nearest(xx - 15, yy - 15, ter_type);
	        dist = my_instance_center_distance(xx, yy, near);
            
	        if(dist != -1 && (nearest_dist == -1 || dist < nearest_dist))
	        {
	            nearest_inst = near;
	            nearest_dist = dist;
	        }
	    }
    
	    /*
	    if(who.blocked_by_perma_structure)
	    {
	        near = my_instance_nearest_in_range(xx, yy, perma_wall_structure_obj, nearest_dist);
        
	        if(near != noone)
	        {
	            nearest_inst = near;
	            nearest_dist = my_instance_center_distance(xx, yy, nearest_inst);
	        }
	    }
	    */
    
	    /*
	    if(who.blocked_by_gate_field)
	    {
	        near = my_instance_nearest_in_range(xx, yy, gate_field_obj, nearest_dist);
        
	        if(near != noone)
	        {
	            nearest_inst = near;
	            nearest_dist = my_instance_center_distance(xx, yy, nearest_inst);
	        }
	    }
	}
	*/

	return nearest_inst;


}
