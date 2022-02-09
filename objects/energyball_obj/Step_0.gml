/// @description DETECT LEAVING GUY'S COLLISION, DESTROY ITSELF IF OUTSIDE OF PLACE, CORNER BOUNCE, PARTICLE BURST
has_left_step();

// TODO: optimize, place_obj should always exist
/*if(speed < 0.5)
{*/
    // DESTROY ITSELF IF OUTSIDE OF PLACE
    if(instance_exists(gamemode_obj.world) && instance_exists(gamemode_obj.world.current_place))
    {
        var place = gamemode_obj.world.current_place;
        if(x+radius < place.x //|| y+radius < place.y
        || x-radius > place.x + place.width
        || y-radius > place.y + place.height)
        {
            collided = true;
            //my_console_log("Energy ball out of bounds DESTROYED");
        }
    }
    else
    {
        if(x+radius < 0 //|| y+radius < 0
        || x-radius > room_width
        || y-radius > room_height)
        {
            collided = true;
            //my_console_log("Energy ball out of bounds DESTROYED");
        }
    }  
//}


// CORNER BOUNCE
if(corner_bounced)
{
    if(!collided && !bounced)
    {
        if(!place_meeting(x+hspeed+hchange,y+vspeed+vchange, solid_terrain_obj))
        {
            //orig_speed = speed;
            hspeed += hchange;
            vspeed += vchange;
            if(orig_speed + speed_delta > 0.2)
            {
                speed = orig_speed + speed_delta;
                if(instance_exists(last_wall_hit) && holographic == last_wall_hit.holographic)
                {
                    last_wall_hit.energy += energy_delta;
                }
            }
            /*
            if(orig_speed > 0.2)
            {
                speed = orig_speed - 0.2;
            }
            */
            else
            {
                vspeed = 0;
                gravity = 0;
            }
            my_sound_play_colored(shot_bounce_sound, my_color, false, sound_volume);
            //show_debug_message("corner bounce applied");
        }
        else
        {
            /*
            if(speed > 0.2)
            {
                speed -= 0.2;
            }
            */
            if(speed + speed_delta > 0.2)
            {
                speed += speed_delta;
                if(instance_exists(last_wall_hit) && holographic == last_wall_hit.holographic)
                {
                    last_wall_hit.energy += energy_delta;
                }
            }
            else
            {
                vspeed = 0;
                gravity = 0;                
            }
        }
    }
    self.corner_bounced = false;
}


// PARTICLE BURST
if(make_particles)
{
    part_emitter_burst(system, em, pt, particle_count);
    part_system_automatic_draw(system, !invisible);
}
