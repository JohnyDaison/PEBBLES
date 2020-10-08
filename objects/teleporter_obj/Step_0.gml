jump_power = min(jump_power + recharge_speed,max_power);
self.ready = (jump_power >= min_power);
invisible = !self.ready;
 
if(self.ready)
{
    with(phys_body_obj)
    {
        var full_speed_meeting = place_meeting(x+hspeed, y+vspeed, other);
        var half_speed_meeting = place_meeting(x+hspeed/2, y+vspeed/2, other);
        /*
        var speed_coef = 0;
        if(full_speed_meeting)
        {
            speed_coef = 1;
        }
        if(half_speed_meeting)
        {
            speed_coef = 0.5;
        }
        */
        
        if(full_speed_meeting || half_speed_meeting)
        {
            //show_debug_message('place_meeting passed');
            trigger(other);
        }
    }
    
    angle += 5;
    angle = angle mod 360;
    scale = 0.9 + sin(degtorad(angle))*0.2;
}
