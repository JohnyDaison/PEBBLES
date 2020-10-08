if(my_guy != id && hold_mode)
{
    if(instance_exists(my_guy.charge_ball))
    {
        var chb_angle = point_direction(0,0, my_guy.charge_ball.rel_x, my_guy.charge_ball.rel_y);
        hold_angle = my_guy.facing * abs(angle_difference(chb_angle, 90))/2;
        
        x = my_guy.charge_ball.x - lengthdir_x(hold_offset, hold_angle);
        y = my_guy.charge_ball.y - lengthdir_y(hold_offset, hold_angle);
        
        var diff = angle_difference(chb_angle + hold_angle, image_angle);
        image_angle += sign(diff) * min(abs(diff), hold_angle_coef*sqrt(abs(diff)));
        
        my_color = my_guy.charge_ball.my_color;
        tint_updated = false;
    }
    
    if(my_guy.dead)
    {
        done_for = true;
    }
}

if(last_my_guy != id && my_guy == id)
{
    done_for = true;   
}


// debug
//name = string(energy);

if(done_for)
{
    /*
    image_index = 1 + fuse_left*image_number;
    image_alpha = fuse_left;
    fuse_left += explode_anim_speed;
    
    if(fuse_left >= 1)
    {*/
        instance_destroy();
        exit;
    /*}
    */
}

event_inherited();