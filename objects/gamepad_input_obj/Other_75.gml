var type = async_load[? "event_type"];
if(type == "gamepad discovered" || type == "gamepad lost" )
{
    if(async_load[? "pad_index"] == index)
    {
        on = gamepad_is_connected(index);

        if(on)
        {
            //gamepad_set_axis_deadzone(index, analog_dead_zone);
            gamepad_set_button_threshold(index, trigger_dead_zone);
        }
    }
}

