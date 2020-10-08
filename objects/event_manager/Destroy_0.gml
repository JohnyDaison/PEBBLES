var count, i, event;

count = ds_list_size(event_list);

for(i = count - 1; i >= 0; i--)
{
    event = event_list[| i];
    ds_list_of_map_destroy(subscriptions[? event]);
}

ds_list_destroy(event_list);
ds_map_destroy(subscriptions);

