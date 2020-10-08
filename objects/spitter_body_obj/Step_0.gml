event_inherited();

var ter, structure, mob, field, ball, target, dist, dir, avoiding = false, old_speed, old_dir, dir_diff;

// COPY GUN COLOR
if(instance_exists(gun))
{
    gun_color = gun.my_color;
    gun_tint = gun.tint;
    
    if(attack_target != noone && gun.cant_hit_target)
    {
        attack_target = noone;
    }
}

// AVOID MOBS
with(mob_obj)
{
    if(id != other.id)
    {
        mob = id;
        with(other)
        {
            dist = point_distance(x,y, mob.x,mob.y);
        
            if(dist < radius + 64 + other.radius)
            {
                dir = point_direction(mob.x,mob.y, x,y);
                /*
                if(speed < max_flight_speed)
                {
                    //motion_add(dir, min(avoid_acc, speed*max(friction+gravity, 1-((dist-radius)/24))));
                    motion_add(dir, avoid_acc);
                }
                else
                {
                    //speed -= tracking_acc + avoid_acc;
                    speed *= 0.5;
                }
                */
        
                motion_add(dir, 2*tracking_acc);
        
                avoiding = true;
                //image_angle = dir;
            }
        }
    }
}


if(avoiding && speed > max_flight_speed)
{
    speed = max_flight_speed;
}

// AVOID TERRAIN
with(terrain_obj)
{
    ter = id;
    with(other)
    {
        dist = point_distance(x, y, ter.x + ter.obj_center_xoff, ter.y + ter.obj_center_yoff);
        var max_dist = radius + 64;
        if(dist < max_dist)
        {
            dir = point_direction(ter.x + ter.obj_center_xoff, ter.y + ter.obj_center_yoff, x, y);
            /*
            if(speed < max_flight_speed)
            {
                motion_add(dir, min(avoid_acc, max(friction+gravity, speed*(1-((dist-radius)/24)))));
            }
            else
            {
                //speed -= tracking_acc + avoid_acc;
                speed *= 0.5;
            }
            */
            
            var dist_coef = 1 - dist/max_dist;
        
            motion_add(dir, dist_coef*3*tracking_acc);
        
            avoiding = true;
            //image_angle = dir;
        }
    }
}

if(avoiding && speed > max_flight_speed)
{
    speed = max_flight_speed;
}

// AVOID GATE FIELDS
with(gate_field_obj)
{
    field = id;
    with(other)
    {
        dist = distance_to_object(field);
        if(dist < radius + 64)
        {
            if(field.vertical)
            {
                dir = point_direction(field.x, 0, x, sign(y - field.y));
            }
            else if(field.horizontal)
            {
                dir = point_direction(0, field.y, sign(x - field.x), y);
            }
        
            motion_add(dir, 3*tracking_acc);
        
            avoiding = true;
            //image_angle = dir;
        }
    }
}

if(avoiding && speed > max_flight_speed)
{
    speed = max_flight_speed;
}

// AVOID TARGET
if(follow_target != id)
{
    with(follow_target)
    {
        target = id;
        with(other)
        {
            dist = point_distance(x,y,target.x,target.y);
            if(dist < radius + attack_hover_dist)
            {
                dir = point_direction(target.x,target.y,x,y);
        
                motion_add(dir, 2*tracking_acc);
        
                avoiding = true;
                //image_angle = dir;
            }
        }
    }
}

if(avoiding && speed > max_flight_speed)
{
    speed = max_flight_speed;
}

// AVOID E-BALLS
with(energyball_obj)
{
    ball = id;
    with(other)
    {
        dist = point_distance(x,y, ball.x,ball.y);
        
        if(dist < radius + 64 + other.radius)
        {
            dir = point_direction(ball.x,ball.y, x,y);
        
            motion_add(dir, 3*tracking_acc);
        
            avoiding = true;
        }
    }
}

if(avoiding && speed > max_flight_speed)
{
    speed = max_flight_speed;
}


// TARGET GUYS
/*
last_follow_target = follow_target;
last_attack_target = attack_target;
*/
guy_dist = -1;
guy = noone;

if(follow_target != id)
{
    if(!instance_exists(follow_target)
    || point_distance(x,y, follow_target.x, follow_target.y) > lockoff_range)
    {
        follow_target = id;
    }
}

if(attack_target != noone)
{
    if(!instance_exists(attack_target)
    || point_distance(x,y, attack_target.x, attack_target.y) > lockoff_range)
    {
        attack_target = noone;
    }
}

with(guy_obj)
{
    dist = point_distance(x,y,other.x,other.y);
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
    follow_target = guy;
    
    follow_x = follow_target.x;
    follow_y = follow_target.y;
    
    var tries = 10;
    while((point_distance(x, y, follow_x, follow_y) < (radius + 64) || place_meeting(follow_x, follow_y, terrain_obj)) && tries > 0)
    {
        follow_x = follow_target.x + irandom_range(-attack_hover_dist, attack_hover_dist);
        follow_y = follow_target.y - attack_hover_dist;
            
        tries--;
    }
    
    attack_target = guy;
}

/*
if(follow_target == noone)
{
    follow_target = id;
    /*
    if(last_follow_target != id)
    {
        follow_x = x;
        follow_y = y;
    }
    */
//}

// FOLLOW
h_diff = follow_x + follow_target.hspeed - (x+hspeed);
v_diff = follow_y + follow_target.vspeed - (y+vspeed);
follow_dir = point_direction(0,0, h_diff, v_diff);

dir_diff = angle_difference(follow_dir, direction);

/*
h_boost = 0;
v_boost = 0;
    
if(abs(h_diff) > 1)
{
    h_boost = h_diff/diff;
}
if(abs(v_diff) > 1)
{
    v_boost = v_diff/diff;
}
*/
    
old_speed = speed;
old_dir = direction;
/*
hspeed += 3*h_boost/sqrt(dist);
vspeed += 3*v_boost/sqrt(dist);
*/

/*
dir_diff = abs(direction-old_dir);
if(dir_diff > 180)
{
    dir_diff = 360 - dir_diff;
}
*/

/*
dir_diff = angle_difference(direction, old_dir);

if((h_boost != 0 || v_boost != 0) && sign(h_boost) != sign(hspeed) && sign(v_boost) != sign(vspeed))
{
    if(abs(dir_diff) < 1)
    {
        direction += sign(dir_diff);   
    }
}
*/

direction += sign(dir_diff) * min(abs(dir_diff), max_rotation_speed);

dir_diff = angle_difference(direction, old_dir);

//debug_str = string(dir_diff);

speed = old_speed - abs(dir_diff)/90;

if(follow_target != id && speed < max_flight_speed)
{
    speed += tracking_acc;   
}

if(follow_target == id)
{
    var speed_diff = min_flight_speed - speed;
    
    speed += sign(speed_diff) * tracking_acc;
}

/*
if(follow_target == id)
{
    speed = 0;
}
*/

/*
if(speed < min_flight_speed)
{
    speed += avoid_acc;   
}
*/


if(my_move_bounce(coltype_var) || my_move_bounce(gate_field_obj))
{
    dir_diff = angle_difference(direction, old_dir);

    speed = old_speed * (1 - (0.5 * abs(dir_diff)/90));
}


// SPEED CAP
if(speed > max_speed)
{
    speed = max_speed;
}

image_angle = direction;


// DEATH
if(damage >= hp)
{
    i = instance_create(x,y, slot_explosion_obj);
    i.my_color = gun_color;
    i.my_source = object_index;
    i.energy = 2.5;
    //i.fire_projectiles = false;
    i.shrapnel_count = 3;
    i.shrapnel_charge = 0.2;
    i.spark_cost = 0.75;
    i.image_angle = image_angle;
    
    done_for = true;
    dead = true;
}

/*
var ter = place_meeting(x+hspeed, y+vspeed, terrain_obj);
var field = place_meeting(x+hspeed, y+vspeed, gate_field_obj);

if(instance_exists(ter) || instance_exists(field))
{
    if(instance_exists(ter))
    {
        my_move_bounce(terrain_obj);
    }
    else if(instance_exists(field))
    {
        my_move_bounce(field);
    }
}
*/
