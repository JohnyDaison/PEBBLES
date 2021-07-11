///@description GUIDING SYSTEM
event_inherited();

// FIND NEW TARGET
// TODO: IMPROVE TARGET CHOICE - MAKE LIST OF CANDIDATES THEN CHOOSE BEST FROM THEM
if(guided && !instance_exists(target))
{
    // TRACK GUYS
    with(guy_obj)
    {
        if(id != other.my_guy && my_player.team_number != other.my_player.team_number
        && point_distance(x,y,other.x,other.y) <= other.guy_lockon_range && !invisible
        && (other.holographic == self.holographic))
        {
            other.target = id;
        }
    }
    
    // TRACK MOBS
    if(!instance_exists(target))
    {
        var near = instance_nearest(x,y,mob_obj);
        if(near != noone && near.id != my_guy && near.my_player != my_player
        && point_distance(x,y,near.x,near.y) <= near.incoming_lockon_range
        && (self.holographic == other.holographic) && small_projectile_line_of_sight(x,y, near))
        {
            target = near;
        }
    }
    
    // TRACK ARTIFACTS
    if(!instance_exists(target))
    {
        var near = instance_nearest(x,y,artifact_obj);
        if(near != noone && near.id != my_guy && point_distance(x,y,near.x,near.y) <= artifact_lockon_range)
        {
            target = near;
        }
    }
    
}

// STOP TRACKING WHEN TARGET GOES INVISIBLE
if(instance_exists(target))
{
    if(target.invisible || (target.holographic != self.holographic))
    {
        target = noone;
    }
}

// ACTUAL GUIDING
if(guided && instance_exists(target) && speed > 0)
{
    dist = point_distance(x,y,target.x,target.y);
    h_diff = target.x+target.hspeed - x+hspeed;
    v_diff = target.y+target.vspeed - y+vspeed;
    diff = (abs(h_diff)+abs(v_diff));
    
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
    
    old_speed = speed;
    old_dir = direction;
    hspeed += 5*h_boost/sqrt(dist);
    vspeed += 5*v_boost/sqrt(dist);
    dir_diff = abs(direction-old_dir);
    if(dir_diff > 180)
    {
        dir_diff = 360 - dir_diff;
    }
    speed = old_speed - dir_diff/90; 
}

// STOP GUIDING IF IT STOPS MOVING
if(speed < stopped_threshold)
{
    guided = false;
}

/*
if(force >= 1)
{
    i = instance_create(x,y,big_projectile_obj);
    i.my_color = my_color;
    i.force = force;
    i.my_guy = my_guy;
    i.direction = direction;
    i.speed = speed;
    
    instance_destroy();
}
*/