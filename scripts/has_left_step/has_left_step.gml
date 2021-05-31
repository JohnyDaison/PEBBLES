/// @function has_left_step
function has_left_step() {
    var index, instance;
    var count = ds_list_size(has_not_left_list);

    for(index = count - 1; index >= 0; index--)
    {
        instance = has_not_left_list[| index];
    
        if(!instance_exists(instance) || !place_meeting(x,y, instance))
        {
            has_left_inst[? instance] = true;
            ds_list_delete(has_not_left_list, index);
        }
    }
}
