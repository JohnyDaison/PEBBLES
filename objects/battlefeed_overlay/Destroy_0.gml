msg_count = ds_list_size(msg_list);
for (var i=0; i < msg_count; i+=1)
{
    var msg_item = msg_list[| i];
    
    if (!is_string(msg_item) && instance_exists(msg_item))
    {
        with(msg_item)
        {
            instance_destroy();
        }
    }
}

ds_list_destroy(msg_list);

event_inherited();
