ds_list_add(fps_list, fps);
ds_list_add(fps_real_list, fps_real);

/*
if(ds_list_size(fps_list) > value_count)
{
    ds_list_delete(fps_list, 0);
    ds_list_delete(fps_real_list, 0);
}
*/

var count = ds_list_size(fps_list);


if(count >= value_count)
{
    var i, fps_total = 0, fps_real_total = 0;
    
    for(i = 0; i < count; i++)
    {
        fps_total += fps_list[| i];
        fps_real_total += fps_real_list[| i];
    }

    average_fps = fps_total/count;
    average_fps_real = fps_real_total/count;
    
    ds_list_clear(fps_list);
    ds_list_clear(fps_real_list);
}