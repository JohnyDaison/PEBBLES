/// @description  ROTATE SLOTS
slot_angle_offset += slot_rot_speed;
if(slot_angle_offset >= 1) { slot_angle_offset -= 1 }; 

for(i=0;i<slot_number;i+=1)
{
    (ds_list_find_value(color_slots,i)).my_angle = (2*pi)*(slot_angle_offset + i/slot_number);    
}

alarm[3] = 2;

