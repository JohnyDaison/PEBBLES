/// HAS_LEFT_INST, PUFF UP, PUSH OTHER, DECAY
event_inherited();
/*
if(instance_exists(my_guy))
{
    if(is_undefined(has_left_inst[? my_guy]) && my_guy != id)
    { 
        has_left_update(my_guy, false);
    }
}
*/
has_left_step();

// PUFF UP
if(scale < 1)
{
    scale = min(1, scale+scale_speed);
}

radius = scale*normal_radius;


// PUSH OTHER SMOKE
with(energy_smoke_obj)
{
    if(other.id != id)
    {
        var dist = point_distance(other.x, other.y, x, y);
        var dir = point_direction(other.x, other.y, x, y);
        var boost = 0.05;
        var coef =  1 -(dist/(2*radius));
        var base_xx = lengthdir_x(coef*boost, dir);
        var base_yy = lengthdir_y(coef*boost, dir);
        
        var full_xx = lengthdir_x(friction + coef*boost, dir);
        var full_yy = lengthdir_y(friction + coef*boost, dir);
        
        if(dist > 0 && dist < 2*radius
        && !place_meeting(x + hspeed + 2*full_xx, y + vspeed + 2*full_yy, solid_terrain_obj))
        {
            //motion_add(dir, friction + coef*boost);
            x += base_xx;
            y += base_yy;
            
            hspeed += full_xx;
            vspeed += full_yy;
            
            if(speed > max_speed)
            {
                speed = max_speed;
            }
        }
    }
}

// DECAY
force -= force_decay;

if(force <= 0)
{
    instance_destroy();
}

