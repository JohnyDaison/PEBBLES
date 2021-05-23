if(holographic == other.holographic)
{
    if(other.my_color == my_color)
    {
        if(instance_exists(col_group))
        {
            if(col_group.resolved)
            {
                self.col_group = noone;
            }
        }
        
        if(!instance_exists(col_group))
        {
            if(instance_exists(other.col_group))
            {
                col_group = other.col_group;
            }
            else
            {
                col_group = instance_create(x,y,collision_group_obj);
            }
            ds_list_add(col_group.members,id);
        }
    }
        
    if(object_index != slime_ball_obj)
    {
        if(my_color > g_dark && my_color < g_white && (other.my_color + my_color) == g_white)
        {
            if(instance_exists(inv_col_group))
            {
                if(inv_col_group.resolved)
                {
                    self.inv_col_group = noone;
                }
            }
            
            if(!instance_exists(inv_col_group))
            {
                if(instance_exists(other.inv_col_group))
                {
                    if(other.inv_col_group.force[? my_color] <= other.inv_col_group.force[? g_white - my_color])
                    {
                        inv_col_group = other.inv_col_group;
                    }
                }
                else
                {
                    inv_col_group = instance_create(x,y,collision_group_obj);
                    inv_col_group.annihilate = true;
                }
                
                if(instance_exists(inv_col_group))
                {
                    ds_list_add(inv_col_group.members,id);
                    inv_col_group.force[? my_color] += force;
                    inv_col_group.ratio_updated = false;
                }
            }
        }
    }
}
