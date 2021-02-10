/// @description ROTATE ORBS
orb_rot_speed = lerp(orb_min_rot_speed, orb_max_rot_speed, charge);
orb_angle_offset += orb_rot_speed;

if(orb_angle_offset >= 1)
{
    orb_angle_offset -= 1;
}

var tau = 2 * pi;
var i, orb;
for(i = 0; i < orb_count; i++)
{
    orb = orbs[| i];
    orb.my_angle = tau * (orb_angle_offset + i / orb_count);
}

alarm[3] = 1;
