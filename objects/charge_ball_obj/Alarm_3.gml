/// @description  ROTATE ORBS
orb_rot_speed = lerp(orb_min_rot_speed, orb_max_rot_speed, charge);
orb_angle_offset += orb_rot_speed;

if(orb_angle_offset >= 1)
{
    orb_angle_offset -= 1;
} 

for(i=0;i<orb_count;i+=1)
{
    (orbs[|i]).my_angle = (2*pi)*(orb_angle_offset + i/orb_count);    
}

alarm[3] = 1;

