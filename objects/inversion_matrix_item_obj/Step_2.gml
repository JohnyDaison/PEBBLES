if(armed)
{
    if(active)
    {
        fuse_left -= fuse_tick;
        /*
        if(instance_exists(my_shield))
        {
            my_shield.x = x;
            my_shield.y = y;
        }
        */
        speed = 0;
        gravity = 0;
        if(fuse_left <= 0)
        {
            if(armed && !gamemode_obj.limit_reached)
            {
                i = instance_create(x,y,slot_explosion_obj);
                i.my_color = my_color;
                i.my_guy = i.id;   
                i.my_source = object_index;
                i.my_player = my_player;
            }
            if(instance_exists(my_shield))
            {
                my_shield.my_guy = my_shield.id;
                my_shield.done_for = true;
            }
            with(emp_grenade_obj)
            {
                if(armed && point_distance(x,y, other.x,other.y) < chain_explosion_range)
                {
                    fuse_left = fuse_tick;   
                }
            }
            
            done_for = true;
            fuse_left = 0;
            armed = false;
            active = false;
        }
    }
}

if(done_for)
{
    image_index = 1 + fuse_left*image_number;
    image_alpha = fuse_left;
    fuse_left += explode_anim_speed;
    
    if(fuse_left >= 1)
    {
        instance_destroy();
        exit;
    }
}

event_inherited();