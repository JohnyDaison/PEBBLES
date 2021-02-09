event_inherited();

// FALLING
if(!immovable)
{
    gravity_direction = 270;
    gravity = 0;
    friction = 0;
    speed = min(speed,max_speed);
    
    if(airborne)
    {
        gravity = 0.04;
        friction = 0.01;
        
        if(y > room_height+32)
        {
            instance_destroy();
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
                        my_sound_play(hit_ground_sound, true);
                        // TODO: Add structure_bounce_sound
                    }
                }
            }
            else
            {
                y -= 32;
                speed = 0;
                gravity = 0;
                //center_y = y-hover_offset;
                airborne = false;
                immovable = true;
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
}

// ADD CHARGEBALL
if(!instance_exists(charge_ball))
{
    my_guy = my_player.my_guy;
    
    if(instance_exists(my_guy))
    {
        ii = instance_create(x,y-128,charge_ball_obj);
        ii.my_guy = id;
        ii.my_player = self.my_player;
        ii.bar_height = 12;
        charge_ball = ii;    
    }
}

// MAIN CYCLE
if(!destroyed && instance_exists(my_guy))
{
    //count = ds_list_size(charges);
    //ball = instance_nearest(x,y, charge_ball_obj);
    
    my_camera = my_guy.my_player.my_camera;
    if(my_camera == noone)
    {
       my_camera = main_camera_obj.id;
    }
    
    // POSITION GUI RELATIVE TO CAMERA
    if(instance_exists(my_camera) && my_camera.on)
    {
        gui_x = my_camera.view_x + my_camera.width - 112; //144
        gui_y = my_camera.view_y + 136;
    }
    
    // GUY INTERACTION
    if(position_meeting(x,y, my_guy) && immovable
     && !(my_guy.looking_down && !my_guy.wanna_cast)
     && !my_guy.jumping_down)
    {
        ball = my_guy.charge_ball;
        draw_label = false;
        
        // LOADING ORBS
        var sound_played = false, full_count = 0;
        for(i=g_red; i<=g_blue; i++)
        {
            if(i==g_yellow) continue;
            
            if(orbs[? i] >= 99)
            {  
                full_count++;
            }
            
            if(my_guy.orb_reserve[? i] >= 1 && orbs[? i] < 99)
            {
                orbs[? i] += 1;
                my_guy.orb_reserve[? i] -= 1;
                orb_light[? i] = 1;
                if(!sound_played)
                {
                    my_sound_play(slot_absorbed_sound);
                    sound_played = true;
                }
                switch(i)
                {
                    case g_red:
                        my_player.stats[? "red_orbs"] += 1;                      
                        break;
                    case g_green:
                        my_player.stats[? "green_orbs"] += 1;
                        break;
                    case g_blue:
                        my_player.stats[? "blue_orbs"] += 1;
                        break;
                }
                my_player.stats[? "total_orbs"] += 1;
                
                // RECOVER FROM NO AMMO
                if(shot_color == g_black)
                {
                    shot_color = i;
                    slots_absorbed = 4;
                    charge_ball.my_color = i;
                    charge_ball.tint_updated = false;
                }
            }   
        }
       
        // CANNON EASTER EGG 
        if(full_count >= 3 && immovable)
        {
            if(my_guy.orb_reserve[? g_red] > 0 || my_guy.orb_reserve[? g_green] > 0 || my_guy.orb_reserve[? g_blue] > 0)
            {
                immovable = false;
                vspeed = -1;
                my_guy.seated = false;
                
                i = instance_create(x,y, slot_explosion_obj);
                i.my_color = my_color;
                i.my_source = object_index;
                my_sound_play(wall_crumble_sound);
                viewshake(my_player.my_camera, 270, 15);
            }
        }
        
        // AIMING
        if(my_guy.seated && my_guy.aim_dist > 0 && my_guy.wanna_cast)
        {
            base_rel_dir = (aim_dir - base_angle + 180)mod 360 -180;
            rel_dir = (my_guy.aim_dir - aim_dir + 180)mod 360 -180;
            cur_aim_speed = aim_speed * ((rel_dir div 45) + sign(rel_dir));
            
            if(cur_aim_speed > abs(rel_dir))
            {
                cur_aim_speed = rel_dir;
            }
            
            if(abs(base_rel_dir + cur_aim_speed) <= (angle_range/2))
            {
                aim_dir += cur_aim_speed;
                aim_dir = aim_dir mod 360;
            }
        }  
    }
    else
    {
        // THROW GUY OUT AND RETURN TO NORMAL CAMERA
        my_guy.seated = false;
        var camera = my_player.my_camera;
        if(camera != noone && camera.follow_shot) {
            camera.follow_shot = false;
            camera.follow_guy = true;
        }
    }
    
    // CHARGING START
    if(!draw_label && charge_ball.charge == 0 && shot_color != g_black)
    {
        charging = true;
    }
     
    // FIRING   
    if(my_guy.fire_cannon)
    {
        if(shot_color == g_black)
        {
            i = instance_create(x, y, text_popup_obj);
            i.str = "OUT OF AMMO!";
            i.my_color = g_red;
            ammo_popup = i;
            
            my_sound_play(cannon_no_ammo_sound);
            
            my_guy.fire_cannon = false;
        }
        
        self.autofire = my_guy.fire_cannon;
    }
    else {
        self.autofire = false;
    }
    
    // SHIELD RECHARGE
    if(!instance_exists(my_shield) && self.shield_ready)
    {
        self.my_shield = instance_create(x,y,shield_obj);
        my_shield.my_guy = id;
        my_shield.my_source = object_index;
        my_shield.max_charge = shield_power - shield_overcharge;
        my_shield.charge = shield_power;
        my_shield.size_coef = 1.2;
        my_shield.low_charge_ratio = 0.5;
        my_shield.field_power = 2;
        my_shield.my_color = shield_color;
        my_shield.my_player = my_player;
        my_sound_play(shield_ready_sound);
    }
}
else
{
    // DON'T FIRE WHEN NOT VALID
    self.autofire = false;
}

// BARREL ANIM
if(shot_color > g_black && charging)
{
    barrel_anim_index = (barrel_anim_index+barrel_anim_speed) mod barrel_anim_length;
}
else
{
    barrel_anim_index = 0;
}

// ORB FADING    
for(col = g_red; col <= g_blue; col++)
{
    if(col == g_yellow) continue;
    
    if(orb_light[? col] > 0)
        orb_light[? col] -= 0.01;
}

// DESTRUCTION
if(damage >= hp && !destroyed)
{
    destroyed = true;
    instance_destroy();
}
