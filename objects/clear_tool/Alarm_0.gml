with(editor_object)
{
    instance_destroy();
}

with(place_obj)
{
    instance_destroy();
}

with(singleton_obj)
{
    event_perform(ev_other,ev_room_end);
    event_perform(ev_other,ev_room_start);
}

alarm[1]=1;

