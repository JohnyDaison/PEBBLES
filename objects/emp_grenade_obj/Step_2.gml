/// @description AIM, CONTROL, EXPLOSION
if(hold_mode)
{
    if(instance_exists(my_guy.charge_ball))
    {
        x = my_guy.charge_ball.x;
        y = my_guy.charge_ball.y;
    }
    else
    {
        x = my_guy.x + lengthdir_x(my_guy.aim_dist, my_guy.aim_dir);
        y = my_guy.y + lengthdir_y(my_guy.aim_dist, my_guy.aim_dir);
    }
}

if(armed && !done_for)
{
    if (placed) {
        fuse_left -= fuse_tick;
    }
    
    if(!active && attached)
    {
        active = true;
        fuse_left = min(fuse_left, attached_fuse_length);
        
        if(!object_is_ancestor(stuck_to.object_index, phys_body_obj))
        {
            my_shield = instance_create(x,y,shield_obj);
            my_shield.my_guy = id;
            my_shield.my_source = object_index;
            my_shield.my_player = my_player;
            my_shield.my_color = my_color;
            my_shield.tint_updated = false;
            my_shield.charge = 5;
            my_shield.max_charge = 5;
            //my_shield.min_size = max_charge;
            my_sound_play(shield_sound);
        }
    }
    
    if(active)
    {
        if(instance_exists(my_shield))
        {
            my_shield.x = x;
            my_shield.y = y;
        }
    }
    
    if(fuse_left <= 0)
    {
        speed = 0;
        gravity = 0;
        
        if(!gamemode_obj.limit_reached)
        {
            var i = instance_create(x,y,slot_explosion_obj);
            i.my_color = my_color;
            i.my_guy = my_guy;
            i.my_source = emp_grenade_obj;
            i.my_player = my_player;
            i.holographic = holographic;
        }
        
        if(instance_exists(my_shield))
        {
            my_shield.my_guy = my_shield.id;
            my_shield.done_for = true;
        }
        
        with(emp_grenade_obj)
        {
            if(self.id != other.id && armed && point_distance(x,y, other.x,other.y) < chain_explosion_range)
            {
                fuse_left = min(fuse_left, 3*fuse_tick);
            }
        }
        
        done_for = true;
        fuse_left = 0;
        armed = false;
        active = false;
    }
}

if(done_for)
{
    speed = 0;
    gravity = 0;
    
    image_index = 1 + fuse_left * (image_number - 2);
    image_alpha = 1 - fuse_left;
    fuse_left += explode_anim_speed;
    
    if(fuse_left >= 1)
    {
        instance_destroy();
        exit;
    }
}

event_inherited();