if(!done_for)
{
    var has_bounced = false;
    if(hspeed != 0)
    {
        hor_dir = sign(hspeed);
    }
    
    if(speed > 1)
    {
        has_bounced = my_move_bounce(coltype_var);
        if(has_bounced)
            speed *= 0.5;
    }
    
    var ter = instance_place(x, y + 1, coltype_var);
    
    if(instance_exists(ter) && !has_bounced)
    {
        if(airborne && speed <= 1)
        {
            if(place_meeting(x, y + 1, coltype_var))
            {
                speed = 0;
                gravity = 0;
                airborne = false;
                alarm[1] = jump_delay;
            }
        }
            
        if(speed == 0)
        { 
            if(alarm[1] == -1 && airborne == true)
            {
                can_jump = false;
                alarm[1] = jump_delay;
            }
            airborne = false;
        }
            
        // fizzle on "hot" terrain
        if(object_is_child(ter, terrain_obj) && my_color != ter.my_color && ter.energy >= ter.damage_threshold)
        {
            done_for = true;
        }
    }
    else
    {
        airborne = true;
    }
    
    /*
    if(!done_for)
    {
        aoe = instance_place(x,y,aoe_obj);
        if(aoe != noone)
        {
            if(aoe.my_color != my_color)
            {
                done_for = true;
            }   
        }
    }
    */
    
    if(!done_for)
    {
        // get absorbed by channeling guy
        guy = instance_place(x,y,guy_obj);
        
        if(instance_exists(guy) && guy.channeling)
        {
            if(guy.damage > guy.min_damage)
            {
                var diff = guy.damage;
                guy.damage = max(guy.damage - energy, guy.min_damage);
                diff -= guy.damage;
                
                create_damage_popup(diff, guy.my_color, guy, "lifespark");
                done_for = true;
                my_sound_play(slot_absorbed_sound);
                increase_stat(guy.my_player, "sparks_absorbed", 1, false);
            }   
        }
    }
    
    // gravity
    if(airborne)
    { 
        gravity = orig_gravity;
    }
    else
    {
        gravity = 0;
    }
    
    
    if(!done_for)
    {
        // jumping
        if(!airborne && speed == 0 && can_jump)
        { 
            hspeed = hor_dir;
            vspeed = -1;
            speed = jump_power;
            if(place_meeting(x+2*hspeed, y+2*vspeed, coltype_var))
            {
                hspeed *= -1;
            }
            x += hspeed;
            y += vspeed;
            can_jump = false;
        }
        
        // loop first 3 images
        if(image_index + image_speed >= 3)
        {
            image_index = 0;
        }
    }
    
    if(done_for)
    {
        // start death anim
        image_index = 3;
        image_speed = 0.5;
        speed = 0;
    }
}

if(done_for)
{
    gravity = 0;
    speed = 0;
    
    // end of death animation
    if(image_index+image_speed >= image_number)
    {
        instance_destroy();
        exit;
    }
}