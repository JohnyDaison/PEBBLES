/// @description ROTATE ORBS
orb_angle_offset += orb_rot_speed;

if(orb_angle_offset >= 1)
{
    orb_angle_offset -= 1;
}

var tau = 2 * pi;
var color, orb, index = 0;
for(color = g_red; color <= g_blue; color++)
{
    if(color == g_yellow) continue;
    
    orb = orbs[? color];
    if (instance_exists(orb)) {
        orb.my_angle = tau * (orb_angle_offset + index / orb_count);
    }
    index++;
}

alarm[3] = 1;
