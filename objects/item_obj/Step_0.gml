event_inherited();

/// @description INVISIBLE, VORTEX, MOVEMENT, STICKY, ARMED
if(instance_exists(my_guy))
{ 
    // INVISIBLE WHILE COLLECTED
    if(object_is_child(my_guy, phys_body_obj) && collected && !used)
    {
        invisible = true;
        if(object_index == color_orb_obj)
        {
            if(color_added || color_held) { //  || color_in_use
                invisible = my_guy.invisible;
            }
        }
        
        if(invisible)
        {
            speed = 0;
            gravity = 0;
            friction = 0;
            fade_counter = 1;
            alarm[1] = -1;
            despawning = false;
            x = my_guy.x;
            y = my_guy.y;
        }
    }
    
    // DRAGGED BY DARK PROJECTILE
    if(my_guy.object_index == black_aoe_obj || my_guy.object_index == black_projectile_obj)
    {
        invisible = false;
        gravity = 4;
        gravity_direction = point_direction(x,y,my_guy.x,my_guy.y);
        friction = 2;
        if(my_guy.object_index == black_projectile_obj) {
            speed = min(speed, 2*my_guy.speed);
        }
        
        airborne = true;
        alarm[1] = -1;
        fade_counter = 1;
        despawning = false;
    }
    
    if(my_guy == self.id || self.placed)
    {
        if(self.placed)
        {
            invisible = false;
        }
        
        // MOVEMENT PHYSICS
        gravity_direction = 270;
        //gravity = 0;
        //friction = 0;
        speed = min(speed,max_speed);    
        
        touching_ground = false;
        top_touching_ground = false;
        touching_entity = noone;
        
        // FREE MOVEMENT
        if(!attached)
        {
            if(airborne)
            {
                gravity = gravity_coef;
                friction = friction_coef;
                
                // FALL OUT OF ROOM
                if(bbox_top > room_height)
                {
                    instance_destroy();
                }
                
                // STICKY
                if(self.sticky)
                {
                    var body;
                    body = instance_place(x+hspeed,y+vspeed, phys_body_obj);
                    if(instance_exists(body) && !body.protected && (holographic || !body.holographic))
                    {
                        if(body.object_index == sprinkler_body_obj)
                        {
                            my_move_bounce(body);
                            my_sound_play(guy_bounce_sound);
                            speed *= 0.8;
                            speed = max(1, speed);
                        }
                        else if(body.my_player != my_player)
                        {
                            stuck_to = body.id;
                            stuck_x = x + hspeed - body.x;
                            stuck_y = y + vspeed - body.y;
                            attached = true;
                        }
                    }
                }
                
                // BOUNCE, HOVER OR ATTACH
                if(!attached)
                {
                    touching_entity = instance_place(x+hspeed,y+vspeed, terrain_obj);
                    touching_ground = instance_exists(touching_entity);
                    if(!touching_ground)
                    {
                        touching_entity = instance_place(x+hspeed,y+vspeed, structure_obj);
                        if(instance_exists(touching_entity) && touching_entity.walkable && (!touching_entity.holographic || self.holographic))
                        {
                            touching_ground = true;
                        }
                        else
                        {
                            touching_entity = noone;
                        }
                    }
                    
                    if(touching_ground)
                    {
                        if(self.sticky)
                        {
                            if(stuck_to == noone)
                            {
                                // ATTACH
                                move_contact_object(hspeed,vspeed, touching_entity);
                                speed = 0;
                                attached = true;
                                stuck_to = touching_entity.id;
                                stuck_x = x - touching_entity.x;
                                stuck_y = y - touching_entity.y;
                                //airborne = false;
                            }
                        }
                        else
                        {
                            if(abs(speed) >= 1)
                            {
                                // BOUNCE
                                my_move_bounce(touching_entity);
                                x = xprevious;
                                y = yprevious;
                                speed *= 0.75;
                                var nearest_player = instance_nearest(x,y, player_guy);
                                if(nearest_player == noone)
                                {
                                    nearest_player = instance_nearest(x,y, guy_obj);
                                    if(instance_exists(nearest_player) && nearest_player.my_player.my_guy != nearest_player)
                                    {
                                        nearest_player = noone;
                                    }
                                }

                                if(nearest_player != noone)
                                {
                                    if(point_distance(x,y,nearest_player.x,nearest_player.y) < DB.sound_cutoff_dist)
                                    {  
                                        my_sound_play(guy_bounce_sound, true);
                                    }
                                }
                            }
                            else
                            {
                                // HOVER
                                y -= 1;
                                speed = 0;
                                gravity = 0;
                                //center_y = y-hover_offset;
                                airborne = false;
                                if(!used) {
                                    alarm[0] = hover_rate;
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                // LANDED
                touching_entity = instance_place(x,y+2, terrain_obj)
                touching_ground = instance_exists(touching_entity);
                if(!touching_ground)
                {
                    touching_entity = instance_place(x,y+2, structure_obj);
                    if(instance_exists(touching_entity) && touching_entity.walkable && (!touching_entity.holographic || self.holographic))
                    {
                        touching_ground = true;
                    }
                    else
                    {
                        touching_entity = noone;
                    }
                }
                
                if(!touching_ground)
                {
                    airborne = true;
                }
                
                var top_touching_entity = instance_place(x+hspeed,y+vspeed-loop_height, terrain_obj);
                top_touching_ground = instance_exists(top_touching_entity);
            }
        }
        else
        {
            // STUCK TO
            speed = 0;
            gravity = 0;
            if(instance_exists(stuck_to))
            {
                x = stuck_to.x + stuck_x;
                y = stuck_to.y + stuck_y;
            }
            else //if(stuck_to != noone)
            {
                attached = false;
                airborne = true;
                stuck_to = noone;
            }
        }
        
        if(despawning && !collected)
        {
            fade_counter -= fade_rate;
            if(fade_counter <= 0)
            {
                instance_destroy();
                exit;
            }
        }
    }
    
    // ARMED
    if(armed)
    {
        armed_blink_phase += armed_blink_dir*armed_blink_step;
        if(abs(armed_blink_phase) >= 1)
        {
            armed_blink_phase = sign(armed_blink_phase);
            armed_blink_dir *= -1;
        }
        
    }
    
    if(last_my_guy != my_guy)
    {
        last_my_guy = my_guy;
    }
    
    /*
    var nearest_guy = instance_nearest(x,y, guy_obj);
    
    if(nearest_guy != noone)
    {
        var dist = point_distance(x,y, nearest_guy.x, nearest_guy.y);
        label_alpha = clamp( dist / (radius +32), 0, 1);
    }*/
}
else
{
    my_guy = self.id;
}

if(use_cooldown_left > 0)
{
    use_cooldown_left--;
}

if(newly_got_steps > 0)
{
    newly_got_steps--;
}

label_distance = base_label_distance + step;
