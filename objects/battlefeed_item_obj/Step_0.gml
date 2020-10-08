if(fade_ratio > battlefeed.fade_speed)
{
    fade_ratio -= battlefeed.fade_speed;
}
else
{
    fade_ratio = 0;

    var msg_index = ds_list_find_index(battlefeed.msg_list, id);
    
    if(msg_index != -1)
    {
        ds_list_delete(battlefeed.msg_list, msg_index);
    }
        
    instance_destroy();
}

