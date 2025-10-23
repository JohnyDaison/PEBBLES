/// @description HANDLE GUYS

/// GRAVITATES TO GUY AND EQUIP ON TOUCH
if(my_guy == id)
{
    var guy = noone;
    var guys = find_nearest_instances(id, guy_obj, 1600, "holographic", holographic);
    if(array_length(guys) > 0)
    {
        var result = guys[0];
        guy = result.id;
    }

    if(instance_exists(guy))
    {
        var xx = guy.x;
        var yy = guy.y;
        
        if(obj_center_offset)
        {
            xx -= lengthdir_x(obj_center_dist, obj_center_angle + image_angle);
            yy -= lengthdir_y(obj_center_dist, obj_center_angle + image_angle);
        }
        move_towards_point(xx, yy, 1);
    }
    var body = instance_place(x,y, phys_body_obj);
    if(body != noone && body.holographic == self.holographic)
    {
        body_equip(body, id);
    }    
}

// POSITIONING ON GUY
if(instance_exists(my_guy) && my_guy != id && hardpoint != -1)
{
    hp_dist = point_distance(0,0,
        my_guy.hardpoint_x[? hardpoint], my_guy.hardpoint_y[? hardpoint]);
    hp_dir = point_direction(0,0,
        my_guy.hardpoint_x[? hardpoint], my_guy.hardpoint_y[? hardpoint])+my_guy.image_angle;
    rot_hp_x = lengthdir_x(hp_dist,hp_dir);
    rot_hp_y = lengthdir_y(hp_dist,hp_dir);
    x = my_guy.x + rot_hp_x;
    y = my_guy.y + rot_hp_y;
    

    
    if(object_is_ancestor(my_guy.object_index, guy_obj))
    {
        if(object_index == sprinkler_shield_obj)
        {
            var equip_count = ds_list_size(my_guy.equipment_list);
            var range = (equip_count-1)*90;
            var des_angle;
        
            if(my_guy.aim_dist > 0)
            {
                des_angle = my_guy.aim_dir + 180 - range/2 + hardpoint*90;
            }
            else
            {
                des_angle = 90 + 90*my_guy.facing - range/2 + hardpoint*90;
            }

            var diff = angle_difference(des_angle, image_angle);
        
            rel_rotation_speed = sign(diff) * min(abs(diff), sqrt(abs(diff)));
            rel_rotation_angle += rel_rotation_speed;
        }
    }
    else if(my_guy.object_index == spitter_body_obj)
    {
        if(object_index == sprinkler_shield_obj)
        {
            //var equip_count = ds_list_size(my_guy.equipment_list);
            //var range = (equip_count-1)*90;
            var des_angle;
        
            des_angle = my_guy.direction; // + 180 - range/2 + hardpoint*90

            var diff = angle_difference(des_angle, image_angle);
        
            rel_rotation_speed = sign(diff) * min(abs(diff), sqrt(abs(diff)));
            rel_rotation_angle += rel_rotation_speed;
        }
    }
    else
    {
        rel_rotation_speed += rel_rotation_delta;
        rel_rotation_angle += rel_rotation_speed;
    }
    
    if(connected_base)
    {
        image_angle = my_guy.image_angle + rel_rotation_angle;
    }
    else
    {
        image_angle = rel_rotation_angle;
    }
    image_angle = image_angle mod 360;
}

event_inherited();