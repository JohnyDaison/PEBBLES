action_inherited();
if(instance_exists(my_guy))
{
    if(active)
    {
        with(item_obj)
        {
            if(id != other.id && !collected && !used)
            {
                if(object_index == crystal_obj)
                {
                    if(is_shielded(id))
                    {
                        continue;
                    }
                }
                if(point_distance(x,y,other.my_guy.x,other.my_guy.y) < other.field_radius)
                {
                    var dir = point_direction(x,y,other.my_guy.x,other.my_guy.y); 
                    var xx = lengthdir_x(other.field_strength, dir);
                    var yy = lengthdir_y(other.field_strength, dir);
                    if(!place_meeting(x+hspeed+xx,y+vspeed+yy, terrain_obj))
                    {
                        hspeed += xx;
                        vspeed += yy;
                    }
                    else
                    {
                        speed *= -0.75;
                    }
                }   
            }
        }
    }
}

