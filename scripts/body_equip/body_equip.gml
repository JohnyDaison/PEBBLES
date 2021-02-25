function body_equip(body, equipment) {
    var i, count, ret = false;
    if(instance_exists(body) && instance_exists(equipment))
    {
        count = ds_list_size(body.equipment_list);
        if(count < body.hardpoint_count)
        {
            for(i=0; i<body.hardpoint_count; i++)
            {
                if(body.hardpoint_type[? i] == equipment.eq_type && body.hardpoint_item[? i] == noone)
                {
                    equipment.my_guy = body.id;
                    equipment.my_player = body.my_player;
                    equipment.hardpoint = i;
                    equipment.octarine_phase_shift = body.octarine_phase_shift + 96;
                    body.hardpoint_item[? i] = equipment.id;
                    ds_list_add(body.equipment_list, equipment.id);
                    ret = true;
                
                    if(body.object_index == sprinkler_body_obj && equipment.object_index == sprinkler_shield_obj)
                    {
                        equipment.rel_rotation_speed = -1;
                        if(i > 0) {
                            equipment.rel_rotation_angle = (body.hardpoint_item[? 0].rel_rotation_angle + 180) mod 360;
                        }
                    }
                
                    break;
                }
            }
        }
    }

    return ret;
}
