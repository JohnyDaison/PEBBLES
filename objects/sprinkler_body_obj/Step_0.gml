event_inherited();

// TARGET GUYS
guy_dist = -1;
guy = noone;
follow_target = noone;
attack_target = noone;

with(guy_obj)
{
    var dist = point_distance(x,y,other.x,other.y);
    if(my_player != other.my_player
        && dist < other.lockon_range && (dist < other.guy_dist || other.guy_dist == -1)
        && !invisible && !protected)
    {
        other.guy = id;
        other.guy_dist = dist;
    }
}

if(instance_exists(guy))
{
    if(guy_dist > radius + 64)
    {
        var dir = point_direction(x,y,guy.x,guy.y);
        if(guy_dist > radius + 256)
        {
            var h_boost = lengthdir_x(tracking_acc, dir);
            var v_boost = lengthdir_y(tracking_acc, dir);
            
            if(!place_meeting(x+hspeed+h_boost, y+vspeed+v_boost, blocking_object) 
            && !place_meeting(x+hspeed+h_boost, y+vspeed+v_boost, gate_field_obj))
            {
                hspeed += h_boost;
                vspeed += v_boost;
            }
            else if(!place_meeting(x+hspeed+h_boost, y+vspeed, blocking_object) 
                 && !place_meeting(x+hspeed+h_boost, y+vspeed, gate_field_obj))
            {
                hspeed += h_boost;
            }
            else if(!place_meeting(x+hspeed, y+vspeed+v_boost, blocking_object)
                 && !place_meeting(x+hspeed, y+vspeed+v_boost, gate_field_obj))
            {
                vspeed += v_boost;
            }
        }
        follow_target = guy;
    }
    attack_target = guy;
}

// AVOID TERRAIN

var nearest_blocker = instance_nearest(x, y, blocking_object);

if(instance_exists(nearest_blocker))
{
    var nearest_blocker_x = nearest_blocker.x;
    var nearest_blocker_y = nearest_blocker.y;
    
    if(nearest_blocker.obj_center_offset)
    {
        nearest_blocker_x += nearest_blocker.obj_center_xoff;
        nearest_blocker_y += nearest_blocker.obj_center_yoff;
    }
    
    if(place_meeting(x,y, nearest_blocker))
    {
        x += sign(x - nearest_blocker_x);
        y += sign(y - nearest_blocker_y);
    }
    
    //dist = point_distance(x, y, nearest_blocker_x, nearest_blocker_y);
    
    var surface_dist = max(0, distance_to_object(nearest_blocker));
    var danger_coef = 1;
    
    danger_coef = sqr(nearest_blocker.energy/nearest_blocker.status_threshold);
    
    if(surface_dist < min_terrain_dist*danger_coef)
    {
        avoiding_acc = max(flight_speed, speed) * ( 1 - (surface_dist / (min_terrain_dist * danger_coef)) );
        dir = point_direction(nearest_blocker_x, nearest_blocker_y, x, y);
        
        var h_boost = lengthdir_x(avoiding_acc, dir);
        var v_boost = lengthdir_y(avoiding_acc, dir);
        
        if(!place_meeting(x+hspeed+h_boost, y+vspeed+v_boost, blocking_object))
        {
            hspeed += h_boost;
            vspeed += v_boost;
        }
        else if(!place_meeting(x+hspeed+h_boost, y+vspeed, blocking_object))
        {
            hspeed += h_boost;
        }
        else if(!place_meeting(x+hspeed, y+vspeed+v_boost, blocking_object))
        {
            vspeed += v_boost;
        }
    }
}

// AVOID BURSTS
var burst = instance_nearest(x, y, energy_burst_obj);
if(instance_exists(burst))
{
    dist = point_distance(x, y, burst.x, burst.y);
    
    var surface_dist = max(0, dist - radius);
    if(surface_dist < min_burst_dist)
    {
        avoiding_acc = flight_speed * ( 1 - (surface_dist / min_burst_dist) );
        dir = point_direction(burst.x, burst.y, x, y);
        
        var h_boost = lengthdir_x(avoiding_acc, dir);
        var v_boost = lengthdir_y(avoiding_acc, dir);
    
        if(!place_meeting(x+hspeed+h_boost, y+vspeed+v_boost, blocking_object))
        {
            hspeed += h_boost;
            vspeed += v_boost;
        }
        else if(!place_meeting(x+hspeed+h_boost, y+vspeed, blocking_object))
        {
            hspeed += h_boost;
        }
        else if(!place_meeting(x+hspeed, y+vspeed+v_boost, blocking_object))
        {
            vspeed += v_boost;
        }
        
        //motion_add(dir, max(friction+gravity, speed) * 0.5 * sqrt( 1 - (surface_dist / 96) ) );
    }
}


// BOUNCE OFF TERRAIN AND GATE FIELDS
if(my_move_bounce(blocking_object))
{
    speed *= 0.8;
}

if(my_move_bounce(gate_field_obj))
{
    speed *= 0.8;
}


if(speed > max_speed)
{
    speed = max_speed;
}

// SOFT SPEED CAP
if(speed > flight_speed)
{
    speed -= breaking_acc;
}


// DEATH
if(damage >= hp)
{     
    i = instance_create(x,y,slot_explosion_obj);
    i.my_color = my_color;
    i.my_source = object_index;
    
    inst = instance_create(x,y, sprinkler_shield_obj);
    inst.my_guy = inst.id;
    inst.protected = true;
    inst.alarm[0] = 10;
    
    done_for = true;
    dead = true;
}
