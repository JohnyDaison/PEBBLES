event_inherited();

if(temporary)
{
    radius -= 1;
    if(radius <= 0)
    {
        instance_destroy();
        exit;
    }
}

width = 2*radius;
height = 2*radius;
field_focus = radius/2;
var force_field = self;
var guy, proj, item;

switch(shape)
{
    case shape_circle:
    
    // GUY
    with(guy_obj)
    {
        if(holographic == other.holographic && my_color != force_field.my_color)
        {
            with(force_field)
            {
                guy = collision_circle(x,y, radius, other.id, false, true);
                if(instance_exists(guy))
                {
                    if(!guy.stuck)
                    {
                        apply_force(guy,repels);
                    }
                }
                guy = noone;
            }
        }
    }
    
    // COLOR PROJECTILES
    with(projectile_obj)
    {
        if(holographic == other.holographic)
        {
            with(other)
            { 
                proj = collision_circle(x,y,radius,other.id,false,true);
                if(instance_exists(proj) && proj.my_color != g_dark)
                {
                    apply_force(proj,repels);
                }
                proj = noone;
            }
        }
    }
    
    // ITEMS
    with(item_obj)
    {
        if(holographic == other.holographic)
        {
            if(instance_exists(my_guy))
            {
                if(!is_shielded(id) && (
                    (my_guy.id == self.id && collectable && !collected)
                    || (!collected && placed && stuck_to == noone) 
                ))
                {
                    with(other)
                    { 
                        item = collision_circle(x,y,radius,other.id,false,true);
                        if(instance_exists(item) && item.my_color != g_dark)
                        {
                            apply_force(item,repels);
                        }
                        item = noone;
                    }
                }
            }
        }
    }
    
    // AOE
    /*
    with(aoe_obj)
    {
        if(holographic == other.holographic)
        {
            with(other)
            { 
                aoe = collision_circle(x,y,radius,other.id,false,true);
                if(instance_exists(aoe))
                {
                    apply_force(aoe,repels);
                }
                aoe = noone;
            }
        }
    }
    */
    
    // DARK PROJECTILES
    /*
    with(black_projectile_obj)
    {
        if(holographic == other.holographic)
        {
            with(other)
            { 
                if(point_distance(x,y,other.x,other.y) < (radius+other.radius))
                {
                    apply_force(other,repels);
                }
            }
        }
    }
    */
    
    // MOBS
    with(mob_obj)
    {
        if(holographic == other.holographic && my_color != other.my_color)
        {
            with(other)
            { 
                if(point_distance(x,y,other.x,other.y) < (radius+other.radius))
                {
                    apply_force(other,repels);
                }
            }
        }
    }
    
    break;
    
    
    case shape_rect:
    
    left_x = round(x-width/2);
    right_x = round(x+width/2);
    top_y = round(y-height/2);
    bottom_y = round(y+height/2);
    
    // GUY
    with(guy_obj)
    {
        if(holographic == other.holographic && (id == force_field.my_guy || my_color != force_field.my_color))
        {
            with(other)
            {
                guy = collision_rectangle(left_x,top_y,right_x,bottom_y,other.id,false,true);
                if(instance_exists(guy))
                {
                    if(guy.id != my_guy && !guy.stuck)
                    {
                        apply_force(guy,repels);
                    }    
                }
                guy = noone;
            }
        }
    }
    
    // COLOR PROJECTILES
    with(projectile_obj)
    {
        if(holographic == other.holographic)
        {
            with(other)
            { 
                proj = collision_rectangle(left_x,top_y,right_x,bottom_y,other.id,false,true);
                if(instance_exists(proj) && proj.my_color != g_dark)
                {
                    apply_force(proj,repels);
                }
                proj = noone;
            }
        }
    }
    
    // AOE
    /*
    with(aoe_obj)
    {
        if(holographic == other.holographic)
        {
            with(other)
            { 
                aoe = collision_rectangle(left_x,top_y,right_x,bottom_y,other.id,false,true);
                if(instance_exists(aoe))
                {
                    apply_force(aoe,repels);
                }
                aoe = noone;
            }
        }
    }
    */
    
    // DARK PROJECTILE
    /*
    with(black_projectile_obj)
    {
        if(holographic == other.holographic)
        {
            with(other)
            { 
                x_dist = abs(x - other.x);
                y_dist = abs(y - other.y);
            
                if((x_dist < width/2+other.radius)
                && (y_dist < height/2+other.radius))
                {
                    apply_force(other,repels);
                }
            }
        }
    }
    */
    
    // MOBS
    with(mob_obj)
    {
        if(holographic == other.holographic && my_color != other.my_color)
        {
            with(other)
            { 
                x_dist = abs(x - other.x);
                y_dist = abs(y - other.y);
            
                if((x_dist < width/2+other.radius)
                && (y_dist < height/2+other.radius))
                {
                    apply_force(other,repels);
                }
            }
        }
    }
    
    break;
    
}
