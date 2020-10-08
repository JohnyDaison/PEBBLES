visible = true;
gravity_direction = 270;
gravity = 0;
friction = 0;
speed = min(speed,max_speed);
 
if(airborne)
{
    gravity = 0.12;
    friction = 0.06;
    
    if(y > room_height+32)
    {
        instance_destroy();
        exit;
    }
    
    if(place_meeting(x+hspeed,y+vspeed,terrain_obj))
    {
        if(abs(speed) >= 1)
        {
            my_move_bounce(terrain_obj);
            vspeed *= 0.25;
            hspeed *= 0.6;
            /*
            if(hspeed == 0)
            {
                hspeed += (sign(random(2)-1)*(random(0.4)+0.2)*speed);
            }
            */
            nearest_guy = instance_nearest(x,y,player_guy);
            if(nearest_guy != noone)
            {
                if(point_distance(x,y,nearest_guy.x,nearest_guy.y) < DB.sound_cutoff_dist)
                {  
                    my_sound_play(hit_ground_sound, false);
                    // TODO: Add structure_bounce_sound
                }
            }
        }
        else
        {

            y -= 1;
            speed = 0;
            gravity = 0;
            //center_y = y-hover_offset;
            airborne = false;
        }
    }
}
else
{
    if(!place_meeting(x,y+2,terrain_obj))
    {
        airborne = true;
    }
}
