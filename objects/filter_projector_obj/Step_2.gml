/// @description COLOR AND POSITION UPDATE

// COLOR
if(instance_exists(my_block))
{
    new_col = my_block.my_color;
    
    if(new_col != my_color)
    {
        my_color = new_col;
        tint_updated = false;
    }
}

// POSITION CHANGED
if(xprevious != x || yprevious != y)
{
    // UPDATE FIELD
    if(instance_exists(my_field))
    {
        my_field.ready = false;
    }
    
    // UPDATE DIRECTION OF PROJECTORS
    if(instance_exists(paired_projector))
    {
        var proj = id, other_proj = paired_projector, dir, tempdir, reldir;
        repeat(2) 
        {
            dir = point_direction(other_proj.x, other_proj.y, proj.x, proj.y);
            tempdir = (round(dir/90)*90) mod 360;
            reldir = dir;
            if(tempdir == 0 && dir > 180)
            {
                reldir = dir -360;
            }
            
            if(abs(tempdir - reldir) < 1)
            {
                proj.image_angle = tempdir;   
            }
            else
            {
                proj.image_angle = round((dir+45)/90)*90 -45;
            }
            
            proj = paired_projector;
            other_proj = id;
        }
    }
}

event_inherited();