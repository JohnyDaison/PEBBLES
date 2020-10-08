if(instance_exists(my_guy) && my_guy != id)
{
    /*
    var index = ds_list_find_index(my_guy.equipment_list, id);
    ds_list_delete(my_guy.equipment_list, index);
    */
    body_unequip(my_guy, self.hardpoint);
}

last_attacker_destroy();

event_inherited();
