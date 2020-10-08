event_inherited();

switch(shape)
{
    case shape_circle:
    
    with(guy_obj)
    {
        with(other)
        { 
            guy = collision_circle(x,y,radius,other.id,false,true);
            if(instance_exists(guy))
            {
                if(guy.id != my_guy)
                {
                    if(guy.has_tped)
                    {
                        //guy.speed = 0;
                        guy.x = guy.pre_tp_x;
                        guy.y = guy.pre_tp_y;
                        guy.last_x = guy.x;
                        guy.last_y = guy.y;
                        guy.has_tped = false;
                    }
                    else
                    {
                        apply_force(guy,repels);
                    }
                }    
            }
            guy = noone;
        }
    }
    
    with(projectile_obj)
    {
        with(other)
        { 
            proj = collision_circle(x,y,radius,other.id,false,true);
            if(instance_exists(proj))
            {
                apply_force(proj,repels,true);
            }
            proj = noone;
        }
    }
    
    with(aoe_obj)
    {
        with(other)
        { 
            aoe = collision_circle(x,y,radius,other.id,false,true);
            if(instance_exists(aoe))
            {
                apply_force(aoe,repels,true);
            }
            aoe = noone;
        }
    }
    
    with(black_projectile_obj)
    {
        with(other)
        { 
            if(point_distance(x,y,other.x,other.y) < (radius+other.radius))
            {
                apply_force(other,repels,true);
            }
        }
    }
    
    with(sprinkler_body_obj)
    {
        with(other)
        { 
            if(point_distance(x,y,other.x,other.y) < (radius+other.radius))
            {
                apply_force(other,repels,true);
            }
        }
    }
    
    break;
    
    
    case shape_rect:
    
    left_x = round(x-width/2);
    right_x = round(x+width/2);
    top_y = round(y-height/2);
    bottom_y = round(y+height/2);
    
    with(guy_obj)
    {
        with(other)
        { 
            guy = collision_rectangle(left_x,top_y,right_x,bottom_y,other.id,false,true);
            if(instance_exists(guy))
            {
                if(guy.id != my_guy)
                {
                    if(guy.has_tped)
                    {
                        //guy.speed = 0;
                        guy.x = guy.pre_tp_x;
                        guy.y = guy.pre_tp_y;
                        guy.last_x = guy.x;
                        guy.last_y = guy.y;
                        guy.has_tped = false;
                    }
                    else
                    {
                        apply_force(guy,repels);
                    }
                }    
            }
            guy = noone;
        }
    }
    
    with(projectile_obj)
    {
        with(other)
        { 
            proj = collision_rectangle(left_x,top_y,right_x,bottom_y,other.id,false,true);
            if(instance_exists(proj))
            {
                apply_force(proj,repels,true);
            }
            proj = noone;
        }
    }
    
    with(aoe_obj)
    {
        with(other)
        { 
            aoe = collision_rectangle(left_x,top_y,right_x,bottom_y,other.id,false,true);
            if(instance_exists(aoe))
            {
                apply_force(aoe,repels,true);
            }
            aoe = noone;
        }
    }
    
    with(black_projectile_obj)
    {
        with(other)
        { 
            x_dist = abs(x - other.x);
            y_dist = abs(y - other.y);
            
            if((x_dist < width/2+other.radius)
            && (y_dist < height/2+other.radius))
            {
                apply_force(other,repels,true);
            }
        }
    }
    
    with(sprinkler_body_obj)
    {
        with(other)
        { 
            x_dist = abs(x - other.x);
            y_dist = abs(y - other.y);
            
            if((x_dist < width/2+other.radius)
            && (y_dist < height/2+other.radius))
            {
                apply_force(other,repels,true);
            }
        }
    }
    
    break;
    
}

