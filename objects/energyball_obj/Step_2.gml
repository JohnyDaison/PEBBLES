/// @description WALLHIT RESOLUTION, ORB-ORB FORCE, FALLING START

// EXPLODE
if(self.collided)
{
    if(!self.shield_hit)
    {
        explo = instance_create(x,y, slot_explosion_obj);
        explo.my_color = my_color;
        explo.my_player = my_player;
        explo.my_guy = explo;
        explo.my_source = object_index;
        explo.fire_projectiles = false;
        explo.create_sparks = false;
        explo.energy = force;
        explo.holographic = holographic;
    }
    instance_destroy();
    exit;
}


// BOUNCE
if(bounced || corner_bounced)
{   
    x += x_return;
    y += y_return;
}

if(place_free(x,y))
{
    self.bounced = false;
}


// COLOR ATTRACTION/REPULSION
with(energyball_obj)
{
    if(id != other.id && object_index != slime_ball_obj && holographic == other.holographic)
    {
        var dist = point_distance(x,y,other.x,other.y);      
        if(dist > 0 && dist < weak_force_range)
        {
            dir = point_direction(x,y,other.x,other.y);
            if(dist < strong_force_range)
               dist = 2*(dist - strong_force_range/2);
               
            if(dist < 0)
               dist = (dist-strong_force_range)*(weak_force_range/strong_force_range); 
            
            if (dist != 0) {
                /*
                if(abs(dist) < 0.1)
                   dist = sign(dist)*0.1;
                   */
                   
                var ratio = get_power_ratio(other.my_color,my_color);
                if(other.my_color == my_color)
                {
                   motion_add(dir, sign(dist)*min(0.15*other.radius/abs(dist/2), other.radius/2));  //-0.015*other.radius/sqrt(abs(dist/2))
                }
                else
                {
                   motion_add(dir+180, 0.1*ratio*other.radius / (dist*(2-ratio)));
                }
            }
        }
    } 
}

var on_terrain = place_meeting(x,y+1, solid_terrain_obj);

if(on_terrain) {
    friction = orig_friction * ground_friction_multiplier;
} else {
    friction = orig_friction;
}

// FALLING START IF STOPPED
if(speed <= stopped_threshold)
{
    was_stopped = true;
    sitting_on_terrain = on_terrain;
    
    if(sitting_on_terrain)
    {
        speed = 0;
        gravity = 0;
        
        if(instance_exists(col_group))
        {
            col_group.sitting_on_terrain = true;
        }
    }
}
else
{
    sitting_on_terrain = false;
}

if(was_stopped && !on_terrain)  
{    
    gravity = gravity_coef;
    
    if(speed <= stopped_threshold)
    {
        var ball = instance_place(x,y, energyball_obj);
        if(instance_exists(ball) && ball.speed < ball.stopped_threshold)
        {
            if(abs(x - ball.x) <= 1) {
                x += choose(-2, 2);
            }
            
            if(ball.y > y && ball.sitting_on_terrain)
            {
                speed = 0;
                gravity = 0;
            }
        }
        
        if(instance_exists(col_group) && col_group.sitting_on_terrain)
        {
            speed = 0;
            gravity = 0;
        }
    }
}


// LIGHT BOOST
ambient_light = orig_ambient_light*light_boost;
direct_light = orig_direct_light*light_boost;
light_boost = 1;


// GATE BOUNCE
if(!gate_bounced)
{
    gate_bounce_count = 0;
}
gate_bounced = false;


// EMIT PARTICLES
part_emitter_region(system,em,x-radius,x+radius,y-radius,y+radius,ps_shape_ellipse,ps_distr_linear);

event_inherited();