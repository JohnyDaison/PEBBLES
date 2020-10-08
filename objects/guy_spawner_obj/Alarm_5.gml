/// @description  ROTATE CRYSTALS
crystal_angle_offset += crystal_rot_speed;
if(crystal_angle_offset >= 1) { crystal_angle_offset -= 1 }; 
crystal_number = ds_list_size(crystals);
for(i=0;i<crystal_number;i+=1)
{
    crystal = crystals[| i];
    if(instance_exists(crystal))
    {
        crystal.my_angle = (2*pi)*(crystal_angle_offset + i/crystal_number);    
    }
    else
    {
        ds_list_delete(crystals, i);
        i--;
        crystal_number--;
    }
}

alarm[5] = 2;

