function body_unequip(body, hardpoint) {
    var i, equipment;
    var success = false;
    
    if(instance_exists(body))
    {
        for(i=0; i<body.hardpoint_count; i++)
        {
            equipment = body.hardpoint_item[? i];
            if(equipment != noone)
            {
                if(i == hardpoint)
                {
                    equipment.my_guy = id;
                    equipment.hardpoint = -1;
                    equipment.octarine_phase_shift = 0;
                    body.hardpoint_item[? i] = noone;
                    ds_list_delete(body.equipment_list, ds_list_find_index(body.equipment_list, equipment.id));
                    success = true;
                }
                else if(i > hardpoint && equipment.eq_type == hp_shield)
                {
                    if(body.hardpoint_item[? i-1] == noone && body.hardpoint_type[? i-1] == equipment.eq_type)
                    {
                        body.hardpoint_item[? i] = noone;
                        body.hardpoint_item[? i-1] = equipment.id;
                        equipment.hardpoint = i-1;
                    }
                }
            }
        }
    }

    return success;
}
