function body_unequip_all(body) {
    var i, item;
    var count = ds_list_size(body.equipment_list);
    for(i = count-1; i >= 0; i--)
    {
        item = body.equipment_list[| i];
        
        if(!is_undefined(item) && instance_exists(item))
        {
            with(item)
            {
                body_unequip(body, item.hardpoint);
            }
        }
    }
}
