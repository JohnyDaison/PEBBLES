near_object = instance_nearest(x,y, object);
dist = point_distance(x,y, near_object.x,near_object.y);
if(dist <= 16)
{
    var group = noone;
    with(obj_group_obj)
    {
        if(self.group_id == other.group_id)
        {
            group = self.id;
        }
    }
    
    if(!instance_exists(group))
    {
        if(instance_exists(object))
        {
            group = create_group(object.object_index);
        }
        else
        {
            group = create_group(object);
        }
        group.group_id = self.group_id;
    }
    
    group_add_member(group, near_object.id, member_id, index);
}

instance_destroy();

